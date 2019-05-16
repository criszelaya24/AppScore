require 'pry'
require 'rest-client'
class ScoreController < ApplicationController
  LAST_SEASON = (Date.today - 1.year).year
  URL = 'https://api.football-data.org/v2/competitions/'
  def index
    @league = params['leagueId']
    @team = params['teamId']
    @condition = get_by_season
    binding.pry
    @data = RestClient.get(URL + @league + @condition, headers = {accept: :json,'X-Auth-Token' => ENV['API_TOKEN']})
  end

  private

  def get_by_season(year = LAST_SEASON)
    @condition = '/matches?season=' + year.to_s
  end
end
