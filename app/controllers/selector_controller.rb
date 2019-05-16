require 'pry'
require 'rest-client'
class SelectorController < ApplicationController
  URL = "https://api.football-data.org/v2/competitions/"
  PREMIER_LEAGUE = 2021
  LA_LIGA = 2014
  SERIE_A = 2019
  BUNDESLIGA = 2004
  def index
    @data = RestClient.get(URL, headers= {accept: :json,'X-Auth-Token' => ENV['API_TOKEN']})
    @leagues = JSON.parse(@data)
  end

  def get_teams
    @league = params[:league]
    @data = RestClient.get(URL + @league + '/teams', headers = {accept: :json,'X-Auth-Token' => ENV['API_TOKEN']})
    @teams_parse = JSON.parse(@data)
    @teams = get_individual_team(@teams_parse)
    render json: {teams: @teams}
  end

  private

  def get_individual_team(teams)
    @teams = []
    teams.each do |key, values|
      if key === "teams"
        values.each do |team|
          @teams.push(team)
        end
      end
    end
    @teams
  end
end
