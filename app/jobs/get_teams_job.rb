class GetTeamsJob < ApplicationJob
  queue_as :default

  def perform
    do_job
  end

  def do_job
    laliga_competition_id = 2014
    laliga_teams = FootballData.fetch(:competitions, :teams, id: laliga_competition_id)
    laliga_teams_past_season = FootballData.fetch(:competitions, :teams, id: laliga_competition_id, season: "2018")
    all_teams = laliga_teams["teams"] + laliga_teams_past_season["teams"]
    all_teams.each do |team|
      if !Team.exists?(:external_id => team["id"].to_i)
        new_team = Team.create(
                        :external_id => team["id"],
                        :tla => team["tla"],
                        :name => team["name"],
                        :short_name => team["shortName"],
                        :crest_url => team["crestUrl"],
                        :address => team["address"],
                        :phone => team["phone"],
                        :website => team["website"],
                        :email => team["email"],
                        :founded => team["founded"],
                        :club_colors => team["clubColors"],
                        :venue => team["venue"],
                        :external_last_updated => team["lastUpdated"]
        )
      end
    end

  end
end
