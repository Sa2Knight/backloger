require 'backlog_kit'
require_relative 'Util'
require_relative 'Backlog'

secret = Util.load_secret_file
client = BacklogKit::Client.new(
  space_id: secret['space_id'],
  api_key: secret['api_key']
)
backlog = Backlog.new(client)
