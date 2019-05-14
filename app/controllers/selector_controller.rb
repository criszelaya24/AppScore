require 'pry'
require 'rest-client'
class SelectorController < ApplicationController
  URL = "https://api.football-data.org/v2/competitions/"
  PREMIER_LEAGUE = 2021
  LA_LIGA = 2014
  SERIE_A = 2019
  BUNDESLIGA = 2004
  def index
    @data = RestClient.get(URL,
    headers= {accept: :json,'X-Auth-Token' => ENV['API_TOKEN']})
    @leagues = JSON.parse(@data)
  end

  def show
    binding.pry
    @message = "Test"
  end
end
