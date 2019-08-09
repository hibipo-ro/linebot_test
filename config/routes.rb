Rails.application.routes.draw do
  post '/callback' => 'linebot#callback'
  get '/callback' => 'linebot#callback'
  post '/replycallback' => 'linereplybot#replycallback'
end
