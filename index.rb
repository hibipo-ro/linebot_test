require 'line/bot'

# columns = { 0 => { 'imageUrl' => 'https://img.dailyportalz.jp/cache/thumbnails/5ab0a4af7ac3b3f3839a878439281386.jpg', 'actions' => { 0 => { 'type' => 'message', 'label' => 'ラベルです', 'text' => 'メッセージ' } } }, 1 => { 'imageUrl' => 'https://img.dailyportalz.jp/cache/thumbnails/5ab0a4af7ac3b3f3839a878439281386.jpg', 'actions' => { 0 => { 'type' => 'message', 'label' => 'ラベルです', 'text' => 'メッセージ' } } } }
# template = { 'type' => 'image_carousel', 'columns' => columns }
# message = { 'type' => 'template', 'altText' => '代替テキスト', 'template' => template }

message = { 'type' => 'text', 'text' => 'こんにちは。テキスト応答ですよ。' }

# message = { 'type' => 'image', 'originalContentUrl' => 'https://img.dailyportalz.jp/cache/thumbnails/5ab0a4af7ac3b3f3839a878439281386.jpg', 'previewImageUrl' => 'https://img.dailyportalz.jp/cache/thumbnails/5ab0a4af7ac3b3f3839a878439281386.jpg' }

client = Line::Bot::Client.new { |config|
    config.channel_secret = "16d4b46218956a056db3c4f4347c8b89"
    config.channel_token = "iHPVoh0hjJevhBJNDV70+ls/K88LAlLmEHifF11gu0ppGsM8QI3r+y3+T/cxzxJOEYRhCLwKTC1a835s6tYFcW6xLcHllGo1Bexsz1ApUrP7RiupYqa+iEqhxyVEp+50K7z6afAVkFdOHzBCbPiqngdB04t89/1O/w1cDnyilFU"
}


response = client.push_message("Ub8c67cfce315de9e3f841e7a2136f5a8", message)
p response



