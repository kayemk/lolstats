require 'dotenv/load'
#require 'active_support'
require 'faraday'
#require 'faraday_middleware'
#require 'faraday-http-cache'

class OverviewController < ApplicationController

  def api_key
    ENV["LOLSTATS_API_KEY"]
  end

  def url
    "https://na1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=stats&dataById=false&api_key="+api_key
  end

  def index
    conn = Faraday.new(url, request: {open_timeout: 5, timeout: 5}) do |c|
      c.response :json, :content_type => /\bjson$/
      c.adapter Faraday.default_adapter
    end

  response = conn.get url
  @hash = response.body['data']

  end
end
