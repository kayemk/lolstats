require 'net/http'
#require 'json'

class OverviewController < ApplicationController
  #default_timeout 1 # hard timeout after 1 second
  def api_key
    ENV["LOLSTATS_API"]
  end

  def index
  url = "https://euw1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=stats&dataById=false&api_key=#{ api_key }"

  uri = URI(url)
  #uri.read_timeout = 30 # seconds
  response = Net::HTTP.get(uri)
  @my_hash = response
  end

  #def 
  #end
end
