from discord_webhook import DiscordWebhook
import yaml
import sys

# https://pypi.org/project/discord-webhook/

webhook_url = ''
with open('secrets.yaml', 'r') as file:
  secrets = yaml.safe_load(file)
  if not secrets['discord']['webhook_url']:
    raise ValueError('Missing discord.webhook_url')
  webhook_url = secrets['discord']['webhook_url']

data = sys.stdin.read()
if not data:
  raise ValueError('Missing something from stdin')

webhook = DiscordWebhook(url=webhook_url, content=data)
response = webhook.execute()
