require 'pry'
require 'rest-client'
class ScoreController < ApplicationController
  LAST_SEASON = (Date.today - 2.year).year
  URL = 'https://api.football-data.org/v2/competitions/'
  def index
    @season = LAST_SEASON
    @total_score = {}
    # get params
    @league = params['leagueId']
    @team_id = params['teamId']
    if @team_id != ''
      flash[:notice] = nil
      @filter = get_by_season
      @data = RestClient.get(URL + @league + @filter, headers = {accept: :json,'X-Auth-Token' => ENV['API_TOKEN']})
      @data_parse = JSON.parse(@data)
      @total_score['firstHalf'], @total_score['secondHalf'], @team_name = get_scores(@data_parse, @team_id)
    else
      flash[:notice] = "You must choose a team!"
    end
  end
  private

  def get_by_season(year = LAST_SEASON)
    @filter = '/matches?season=' + year.to_s
  end

  def get_scores(data, team)
    @first_half = 0
    @second_half = 0
    data.each do |key, matches|
      if key == "matches"
        matches.each do |match|
          if match['homeTeam']['id'] == team.to_i
            @team_name = match['homeTeam']['name']
             @first_half, @secondHalf = home_away(match, "homeTeam")
            elsif match['awayTeam']['id'] == team.to_i
              @team_name = match['awayTeam']['name']
              @first_half, @secondHalf = home_away(match, "awayTeam")
          end
        end
      end
    end
    return  @first_half, @second_half, @team_name
  end

  private

  def home_away(match, home_away)
    @first_half += match['score']['halfTime'][home_away]
    if match['score']['halfTime']['homeTeam'] == match['score']['fullTime'][home_away]
      @second_half += 0
    else
      @second_half += match['score']['fullTime']['homeTeam'] - match['score']['halfTime'][home_away]
    end
    return @first_half, @second_half
  end
end
