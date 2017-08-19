require 'net/http'
require 'dotenv/load'
#require 'json'

class OverviewController < ApplicationController
  #default_timeout 1 # hard timeout after 1 second
  def api_key
    ENV["LOLSTATS_API_KEY"]
    @test_debug = ENV["LOLSTATS_API_KEY"]
  end

  def handle_timeouts
    begin
      yield
    rescue Net::OpenTimeout, Net::ReadTimeout
      {}
    end
  end


  def index
    handle_timeouts do
      url = "https://na1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&dataById=false&api_key=#{ api_key }"
      uri = URI(url)
      response = Net::HTTP.get(uri) 
      @url_debug = url
      @my_hash = response
    end
  end

  #def 
  #end
end
