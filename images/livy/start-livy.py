import json, pprint, requests, textwrap
host = 'https://livy.k8s.home.kagesenshi.org'
data = {'kind': 'spark'}
headers = {'Content-Type': 'application/json'}
r = requests.post(host + '/sessions', data=json.dumps(data), headers=headers)
r.json()
