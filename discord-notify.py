import argparse
from discord_webhook import DiscordWebhook
import sys
import yaml

# Documentation: https://pypi.org/project/discord-webhook/

parser = argparse.ArgumentParser(
    description='Send Farm Discord notifications.')
parser.add_argument('--config', nargs='?', default='./secrets.yaml',
                    type=str, help='YAML config. Default: ./secrets.yaml.')

args = parser.parse_args()
d = vars(args)
webhook_url = ''
with open(d['config'], 'r') as file:
    secrets = yaml.safe_load(file)
    if not secrets['discord']['webhook_url']:
        raise ValueError('Missing discord.webhook_url')
    webhook_url = secrets['discord']['webhook_url']

data = sys.stdin.read()
if not data:
    raise ValueError('Missing something from stdin')

webhook = DiscordWebhook(url=webhook_url, content=data)
response = webhook.execute()
