import requests
import argparse
import json

import sys

parser = argparse.ArgumentParser()
parser.add_argument('-s', '--ranger-server-url', required=True)
parser.add_argument('-u', '--admin-username', required=True)
parser.add_argument('-p', '--admin-password', required=True)
parser.add_argument('-t', '--service-type', required=True)
parser.add_argument('-n', '--service-name', required=True)
parser.add_argument('-d', '--service-description', default='', required=False)
parser.add_argument('-k', '--no-verify', action='store_true', default=False, required=False)
parser.add_argument('-c', '--configs', required=True)
parser.add_argument('-i', '--ignore-error', action='store_true', default=False, required=False)

args = parser.parse_args()

data={'isEnabled': True, 
      'name': args.service_name, 
      'type': args.service_type, 
      'description': args.service_description,
      'configs': json.loads(args.configs) }

resp = requests.post('%s/service/public/v2/api/service' % args.ranger_server_url, auth=(args.admin_username, args.admin_password), json=data, verify=not args.no_verify)

print('Status Code: ', resp.status_code)
print(resp.text)

if not args.ignore_error:
    sys.exit(resp.status_code)
