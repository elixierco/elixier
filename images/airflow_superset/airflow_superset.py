import argparse
import sys
import os
import requests
import json
import jinja2 as j2

templates = j2.Environment(loader=j2.FileSystemLoader(os.path.join(os.path.dirname(__file__), 'templates')), autoescape=j2.select_autoescape)

class SupersetAPI(object):

    def __init__(self, url, username, password, insecure=False):
        url = url.strip()
        if not url.endswith('/'):
            url = url + '/'
        self.base_url = url
        self.username = username
        self.password = password
        self.token = None
        self.verify_ssl = not insecure

    def endpoint(self, path):
        if path.startswith('/'):
            path = path[1:]
        return self.base_url + path

    def authenticate(self):
        res = requests.post(self.endpoint('api/v1/security/login'), 
                            json={'username':self.username, 
                                  'password': self.password, 
                                  'provider': 'db', 
                                  'refresh': True},
                            verify=self.verify_ssl)
        token = {'Authorization': 'Bearer %s' % res.json()['access_token']}
        self.token = token
        return token

    def get_saved_queries(self, token=None):
        if token is None:
            token = self.token
        return requests.get(self.endpoint('api/v1/saved_query'), headers=token, verify=self.verify_ssl).json()

    def get_database_info(self, db_id, token=None):
        if token is None:
            token = self.token
        return requests.get(self.endpoint('api/v1/database/%s' % db_id), headers=token, verify=self.verify_ssl).json()


def generate_dag(config, output_directory):
    dag_template = templates.get_template('superset_dag.py.j2')
    if not os.path.exists(output_directory):
        os.makedirs(output_directory)

    tempfile = os.path.join(output_directory, 
                            'superset_saved_query_%s.tmp' % config['id'])
    outfile = os.path.join(output_directory,
                           'superset_saved_query_%s.py' % config['id'])

    with open(tempfile, 'w') as f:
        f.write(dag_template.render(config=config))

    os.replace(tempfile, outfile)

def main(argv):
    parser = argparse.ArgumentParser()
    parser.add_argument('-u','--superset-url', required=True)
    parser.add_argument('-U','--username', required=True)
    parser.add_argument('-P','--password', required=True)
    parser.add_argument('-O','--output-directory', required=True)
    parser.add_argument('--insecure', required=False, action='store_true', default=False)

    args = parser.parse_args(argv)

    api = SupersetAPI(args.superset_url, args.username, args.password, insecure=args.insecure)
    token = api.authenticate()
    queries = api.get_saved_queries()['result']

    dbs = {}

    dag_configs = []
    for query in queries:
        if 'extra' not in query:
            continue
        if 'schedule_info' not in query['extra']:
            continue
        schedule = query['extra']['schedule_info']
        db_id = query['db_id']
        if db_id not in dbs:
            dbs[db_id] = api.get_database_info(db_id)['result']
        sql = query['sql']
        dag_configs.append({
            'id': query['id'],
            'database': dbs[db_id],
            'sql': sql,
            'schedule': schedule
        })

    for conf in dag_configs:
        generate_dag(conf, output_directory=args.output_directory)

if __name__ == '__main__':
    main(sys.argv[1:])
