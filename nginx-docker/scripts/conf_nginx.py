import os
import re

from jinja2 import Template


BACKEND_PATTERN = r'^WEB_BACKEND_PORT_(\d+)_TCP_ADDR'
BACKEND_PORT = 8000
SEARCH_BACKEND_PATTERN = r'SEARCH_BACKEND_PORT_(\d+)_TCP_ADDR'
SEARCH_BACKEND_PORT = 5000


def main():
    print os.environ
    web_server_ips = [os.environ[var] for var in os.environ if re.search(BACKEND_PATTERN, var)]
    search_server_ips = [os.environ[var] for var in os.environ if re.search(SEARCH_BACKEND_PATTERN, var)]
    with open('nginx.template') as template_file:
        template = Template(template_file.read())
        web_server = {
            'ip': web_server_ips[0],
            'port': BACKEND_PORT,
        }
        search_server = {
            'ip': search_server_ips[0],
            'port': SEARCH_BACKEND_PORT,
        }
        with open('/etc/nginx/sites-enabled/django.conf', 'w') as nginx_conf:
            nginx_conf.write(template.render(web_server=web_server,
                                             search_server=search_server))
    with open('/etc/nginx/sites-enabled/django.conf') as nginx_conf:
        print(nginx_conf.read())


if __name__ == '__main__':
    main()
