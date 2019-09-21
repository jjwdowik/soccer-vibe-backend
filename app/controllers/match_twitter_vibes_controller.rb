class MatchTwitterVibesController < ApplicationController

  def index
    if params[:match_id].present?
      @match_twitter_vibes = MatchTwitterVibe.where(:match_id => params[:match_id]).order(:twitter_created_at)
    else
      @match_twitter_vibes = MatchTwitterVibe.all.order(:twitter_created_at)
    end
    @average_score = @match_twitter_vibes.any? ? @match_twitter_vibes.average(:score).round(2) : "N/A"

    render 'match_twitter_vibes/index.json.jb'
  end

end