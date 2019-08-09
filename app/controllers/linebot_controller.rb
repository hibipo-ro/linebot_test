class LinebotController < ApplicationController
  require 'line/bot'

  require 'open-uri'
  require 'json'

  protect_from_forgery :except => [:callback]
  def callback
    body = request.body.read
    signature = request.env['HTTP_X_LINE_SIGNATURE']
  #  unless client.validate_signature(body, signature)
  #    error 400 do 'Bad Request' end
  #  end
    events = client.parse_events_from(body)

    array = {}
    message = {}
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          ##ぐるナビAPI叩いて返す

          
         uri   = "https://api.gnavi.co.jp/RestSearchAPI/20171214/"

	acckey= "6afcd32694c4130f6a1ce4a7dc21a98b"

	format= "json"
	#lat   = 35.670083
	#lon   = 139.763267
	#range = 1
	freeword = event.message['text']
	#prefname = event.message['text']
	p event.message['text'] 
	#range = open(url)
	
	#line = {
         #   type: 'text',
          #  text: event.message['text']
           # }

	url  = sprintf("%s%s%s%s%s%s%s", uri, "?format=", format, "&keyid=", acckey, "&freeword=", freeword)
	url = URI.encode url
	p url
	json = open(url)
	#array = {}
	json.each do |j|
	    array = JSON.parse(j)
	end

	msg = ''

	array["rest"].each do |rest|
	     #puts rest["name"]
	     msg = msg + rest["name"] 
	     message = { 'type' => 'text', 'text' => rest["name"] }
#	     response = client.push_message("Ub8c67cfce315de9e3f841e7a2136f5a8", message)
	     #puts response

            #message = {
            #type: 'text',
            #text: event.message['text']
            #}
	end
msgmsg = { 'type' => 'text', 'text' => msg }


          #message = {
            #type: 'text',
            #text: event.message['text']
           #}
        end
      end

      #p array
      client.reply_message(event['replyToken'], msgmsg)
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
