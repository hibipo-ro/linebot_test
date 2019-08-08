require 'open-uri'
require 'json'
require 'line/bot'


uri   = "https://api.gnavi.co.jp/RestSearchAPI/20171214/"

acckey= "6afcd32694c4130f6a1ce4a7dc21a98b"

format= "json"
lat   = 35.670083
lon   = 139.763267
range = 1


url  = sprintf("%s%s%s%s%s%s%s%s%s%s%s", uri, "?format=", format, "&keyid=", acckey, "&latitude=", lat,"&longitude=",lon,"&range=",range)

json = open(url)
array = {}
json.each do |j|
    array = JSON.parse(j)
end
client = Line::Bot::Client.new { |config|
    config.channel_secret = "16d4b46218956a056db3c4f4347c8b89"
    config.channel_token = "iHPVoh0hjJevhBJNDV70+ls/K88LAlLmEHifF11gu0ppGsM8QI3r+y3+T/cxzxJOEYRhCLwKTC1a835s6tYFcW6xLcHllGo1Bexsz1ApUrP7RiupYqa+iEqhxyVEp+50K7z6afAVkFdOHzBCbPiqngdB04t89/1O/w1cDnyilFU"
}

array["rest"].each do |rest|
    # puts rest["name"]
    message = { 'type' => 'text', 'text' => rest["name"] }
    response = client.push_message("Ub8c67cfce315de9e3f841e7a2136f5a8", message)
    puts response
end

# message = { 'type' => 'text', 'text' => 'こんにちは。テキスト応答ですよ。' }


# response = client.push_message("Ub8c67cfce315de9e3f841e7a2136f5a8", message)
# p response