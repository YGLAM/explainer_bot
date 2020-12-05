require 'telegram/bot'
require 'net/http'
require 'json'
require_relative 'bot.rb'

class Explain

  def self.searchfor(request)
    url = "http://api.urbandictionary.com/v0/define?term="+request
    uri = URI(url)
    response = Net::HTTP.get(uri)
    puts "Looking for #{uri}\n"
    response = JSON.parse(response)
    return response
  end
end
