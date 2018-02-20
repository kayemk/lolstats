require 'faraday'
require 'dotenv/load'
#require 'faraday_middleware'

class OverviewController < ApplicationController

  def api_key
    ENV["LOLSTATS_API_KEY"]
  end

  def url
    "https://na1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=stats&dataById=false&api_key="+api_key
  end

  def index
    conn = Faraday.new(url, request: {open_timeout: 5, timeout: 5}) do |c|
      c.use Faraday::HttpCache, logger: ActiveSupport::Logger.new(STDOUT)
      #c.use FaradayMiddleware::ParseJson, content_type: 'application/json'
      #c.response :xml,  :content_type => /\bxml$/
      c.response :json, :content_type => /\bjson$/
      # c.use Faraday::Response::Logger     # log request & response to STDOUT
      c.adapter Faraday.default_adapter
      #c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
    end
  #end
  response = conn.get url
  @hash = response.body['data']

  end
end
