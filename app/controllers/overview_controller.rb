require 'faraday'
require 'dotenv/load'
require 'faraday_middleware'

class OverviewController < ApplicationController

  def api_key
    ENV["LOLSTATS_API_KEY"]
  end

  def url
    "https://euw1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=stats&dataById=false&api_key="+api_key
  end

  def index

    conn = Faraday.new(url, request: {open_timeout: 1, timeout: 1}) do |c|
      c.use FaradayMiddleware::ParseJson,       content_type: 'application/json'
      c.use Faraday::Response::Logger     # log request & response to STDOUT
      c.use Faraday::Adapter::NetHttp     # perform requests with Net::HTTP
    end

  response = conn.get url
  @my_hash = response.body
  # Jax
  @champs_name = response.body['data']['Jax']['name']
  @champs_armor = response.body['data']['Jax']['stats']['armor']
  @champs_armorperlevel = response.body['data']['Jax']['stats']['armorperlevel']
  @champs_attackdamage = response.body['data']['Jax']['stats']['attackdamage']
  # Annie
  @champss_name = response.body['data']['Annie']['name']
  @champss_armor = response.body['data']['Annie']['stats']['armor']
  @champss_armorperlevel = response.body['data']['Annie']['stats']['armorperlevel']
  @champss_attackdamage = response.body['data']['Annie']['stats']['attackdamage']

  end

end
