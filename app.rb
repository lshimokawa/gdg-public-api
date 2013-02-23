require 'sinatra'
require 'json'
require 'nokogiri'
require 'open-uri'

get '/events/:id' do
  content_type :json
  url = "https://developers.google.com/events/#{params[:id]}/"
  data = Nokogiri::HTML(open(url))

  map = Hash.new
  data.css("header").each do |item|  
    key = item.text.strip.delete(":").downcase.gsub(/\s+/, "_")
    value = item.next.text.strip  
    map[key] = value
  end

  map.to_json
end