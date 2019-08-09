Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/callback' => 'linebot#callback'
  post '/callbacks' => 'linebot#callback'
end
