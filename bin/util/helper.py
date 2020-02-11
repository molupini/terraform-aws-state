import requests
from os import environ
from os import getcwd
import fire
import json
import re


class HttpFetch(object):
    
    def app(self, id, document='tag', res='null'):
        # WEB REQUEST
        protocol = environ.get('IAC_ENDPOINT_PROTOCOL')
        hostname = environ.get('IAC_ENDPOINT_HOSTNAME')
        port = environ.get('IAC_ENDPOINT_PORT')
        uri = f'{protocol}://{hostname}:{port}'
        url = f'{uri}/app/{id}?document={document}'
        response = requests.get(url)
        # WEB RESULT
        if response.status_code != 200 and response.status_code != 201 and response.status_code != 202:
            err = {'error': f'web {response.status_code}'}
            raise Exception(err)
        # TO JSON
        deploy = response.json()
        if deploy:
            if res != 'null':
                try:
                    return json.dumps(deploy[res], separators=(',',':'), indent=2)
                except:
                    # RETURN EMPTY ARRAY TO PREVENT RESOURCE USAGE WITH COUNT PARAM
                    err = {'error': f'not found {res}'}
                    empty = json.dumps([])
                    return empty
            return json.dumps(deploy, separators=(',',':'), indent=2)
        else:
            return 1

    def status(self, id, code=0):
            # WEB REQUEST
            protocol = environ.get('IAC_ENDPOINT_PROTOCOL')
            hostname = environ.get('IAC_ENDPOINT_HOSTNAME')
            port = environ.get('IAC_ENDPOINT_PORT')
            uri = f'{protocol}://{hostname}:{port}'
            url = f'{uri}/app/deployment/{id}?state={code}'
            try:
                response = requests.get(url)
                if response.status_code != 200 and response.status_code != 201 and response.status_code != 202:
                    err = {'error': f'resource state, web {response.status_code}'}
                    raise Exception(err)
                return 0
            except:
                return 1


if __name__ == '__main__':
    fire.Fire(HttpFetch)