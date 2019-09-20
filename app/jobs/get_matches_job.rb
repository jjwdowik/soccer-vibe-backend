class GetMatchesJob < ApplicationJob
  queue_as :default

  def perform
    do_job
  end

  def do_job
    # for now just get the la liga
    laliga_id = "PD"
    laliga_competition_id = 2014
    laliga_data = FootballData.fetch(:competitions, :matches, id: laliga_id)

    laliga_data["matches"].each do |match|
      winner_external_id = nil
      winner_side = nil
      if match["score"]["winner"] != "DRAW"
        if match["score"]["winner"] == "AWAY_TEAM"
          winner_external_id = match["awayTeam"]["id"]
          winner_side = match["awayTeam"]["name"]
        elsif match["score"]["winner"] == "HOME_TEAM"
          winner_external_id = match["homeTeam"]["id"]
          winner_side = match["homeTeam"]["name"]
        end
      end

      if !Match.exists?(:external_match_id => match["id"].to_i)
        new_match = Match.create(
                     :league_id => laliga_id,
                     :external_match_id => match["id"],
                     :winner_side => winner_side,
                     :winner_external_id => winner_external_id,
                     :away_team_external_id => match["awayTeam"]["id"],
                     :away_team => match["awayTeam"]["name"],
                     :home_team_external_id => match["homeTeam"]["id"],
                     :home_team => match["homeTeam"]["name"],
                     :status => match["status"],
                     :start_time => DateTime.parse(match["utcDate"]),
                     :data => match)
      else
        found_match = Match.where(:external_match_id => match["id"].to_i).first
        found_match.update_attributes(
                     :winner_side => winner_side,
                     :winner_external_id => winner_external_id,
                     :status => match["status"],
                     :data => match)
      end

    end

  end
end
