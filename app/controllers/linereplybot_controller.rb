class LinereplybotController < ApplicationController
  require 'line/bot'
  require 'open-uri'
  require 'json'

  protect_from_forgery :except => [:replycallback]
  def replycallback
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

	acckey= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

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
	purl = URI.encode url
	p url
	json = open(url)
	#array = {}
	json.each do |j|
	    array = JSON.parse(j)
	end

	msg = ''
        columns = [];
	array["rest"].each do |rest|
	     #puts rest["name"]
	     msg = msg + rest["name"] 
	     message = { 'type' => 'text', 'text' => rest["name"] }
#	     response = client.push_message("Ub8c67cfce315de9e3f841e7a2136f5a8", message)
	     #puts response
             columns.push({
                 "thumbnailImageUrl": rest["image_url"]["shop_image1"],
                 "title": rest["name"],
                 "text": rest["tel"],
                 "actions": [
                 {
                     "type": "uri",
                     "label": "電話する",
                     "uri": "tel://" + rest["tel"]
		 },
                 {
                     "type": "uri",
                     "label": "お店のページへ",
                     "uri": rest["url"]
                 }]
             });
            #message = {
            #type: 'text',
            #text: event.message['text']
            #}
	end

message = [
    {
        "type": "template",
        "altText": "this is a carousel template",
        "template": {
            "type": "carousel",
            "columns": columns
        }
    },
    {
        "type": "text",
        "text": "ggggg"
   }
]
          #message = {
            #type: 'text',
            #text: event.message['text']
           #}
        end
      end

      #p array
      client.reply_message(event['replyToken'], message)
#      addmessage = { 'type' => 'text', 'text' => "hogehoge" }
#      client.reply_message(event['replyToken'], addmessage)
    end
    head :ok
  end

private

# LINE Developers登録完了後に作成される環境変数の認証
  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
      config.channel_token = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
    }
  end
end
