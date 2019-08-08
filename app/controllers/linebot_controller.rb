class LinebotController < ApplicationController
  require 'line/bot'

  protect_from_forgery :except => [:callback]
  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
  #  unless client.validate_signature(body, signature)
  #    error 400 do 'Bad Request' end
  #  end
    events = client.parse_events_from(body)

    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          ##ぐるナビAPI叩いて返す

          

          message = {
            type: 'text',
            text: event.message['text']
          }
        end
      end
      client.reply_message(event['replyToken'], message)
    end
    head :ok
  end

private

# LINE Developers登録完了後に作成される環境変数の認証
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = "16d4b46218956a056db3c4f4347c8b89"
      config.channel_token = "iHPVoh0hjJevhBJNDV70+ls/K88LAlLmEHifF11gu0ppGsM8QI3r+y3+T/cxzxJOEYRhCLwKTC1a835s6tYFcW6xLcHllGo1Bexsz1ApUrP7RiupYqa+iEqhxyVEp+50K7z6afAVkFdOHzBCbPiqngdB04t89/1O/w1cDnyilFU="
    }
  end
end
