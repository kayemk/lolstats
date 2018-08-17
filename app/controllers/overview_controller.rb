require 'dotenv/load'
#require 'active_support'
require 'faraday'
#require 'faraday_middleware'
#require 'faraday-http-cache'

#class OverviewController < ApplicationController
#class is actually only for api connection
class StatsClient

  def api_key
   ENV["APIKEY"]
  end

  def url
    "https://na1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=stats&dataById=false&api_key="+api_key
  end

  def champs
    conn = Faraday.new(url, request: {open_timeout: 5, timeout: 5}) do |c|
      c.response :json, :content_type => /\bjson$/
      c.use Faraday::Response::Logger     # log request & response to STDOUT
      c.adapter Faraday.default_adapter
    end
  response = conn.get url
  #@hash = response.body['data']
  response.body['data']
  end
end

class OverviewController < ApplicationController
  def index
    @hash = Rails.cache.fetch('data', expires_in: 8.hours) do
      StatsClient.new.champs
    end

    def cached
    puts Rails.cache.exists?('data')
    end
  end
end
