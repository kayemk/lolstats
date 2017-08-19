require 'faraday'
require 'dotenv/load'

class OverviewController < ApplicationController

  def api_key
    ENV["LOLSTATS_API_KEY"]
  end

  def url
    "https://euw1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=stats&dataById=false&api_key="+api_key
  end

  def index

    conn = Faraday.new(url, request: {open_timeout: 1, timeout: 1}) do |c|
      c.use Faraday::Response::Logger     # log request & response to STDOUT
      c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
    end
  response = conn.get url
  @my_hash = response.body
  end

end
