require 'pusher'

CHANNELS_CLIENT = Pusher::Client.new(
  app_id: ENV['PUSHER_APP_ID'],
  key: ENV['PUSHER_KEY'],
  secret: ENV['PUSHER_SECRET'],
  cluster: 'us2',
  encrypted: true
)
