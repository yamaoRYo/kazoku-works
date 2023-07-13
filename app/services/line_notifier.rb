require 'line/bot'

class LineNotifier
    def initialize
        @client = Line::Bot::Client.new do |config|
            config.channel_secret = ENV['LINE_CHANNEL_SECRET']
            config.channel_token = ENV['LINE_CHANNEL_TOKEN']
        end
    end

    def send_message(user_id, message)
        message = {
            type: 'text',
            text: message
        }
        response = @client.push_message(user_id, message)
        response.code == 200
    end
end
