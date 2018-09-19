#require 'dotenv/load'
#require 'active_support'
require 'net/http'
require 'net/https'
require 'faraday'
require 'json'
#require 'faraday_middleware'
#require 'faraday-http-cache'

#class OverviewController < ApplicationController
#class is actually only for api connection
class StatsClient

  def api_key
   ENV["APIKEY"]
  end

  def live_version
    uri = URI('https://ddragon.leagueoflegends.com/api/versions.json')

    # Create client
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

  # Create Request
    json = Net::HTTP::Get.new(uri)

  # Fetch Request
    res = http.request(json)
    result = JSON.parse(res.body)
    puts "Response HTTP Status Code: #{res.code}"
    #puts "Response HTTP Response Body: #{res.body}"
    puts result[0]
  rescue StandardError => e
    puts "HTTP Request failed (#{e.message})"
  end

  def url
    "http://ddragon.leagueoflegends.com/cdn/8.12.1/data/en_GB/champion.json"
#    "https://na1.api.riotgames.com/lol/static-data/v3/champions?locale=en_US&tags=stats&dataById=false&api_key="+api_key
  end

  #def imgurl
  #  "http://ddragon.leagueoflegends.com/cdn/"+live_version"/img/champion/"
  #end

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
