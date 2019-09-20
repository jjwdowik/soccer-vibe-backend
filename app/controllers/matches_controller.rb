class MatchesController < ApplicationController
  before_action :scope_matches, only: [:index]

  def index
    data = {:matches => @matches, :teams => Team.all}
    render :json => data
  end

  def show
    @match = Match.find(params[:id])
    render :json => @match.to_json
  end

  def update_hashtag
    @match = Match.where(:league_id => params[:id], :external_match_id => params[:match_id]).first
    if @match.present?
      @match.update_attributes(:twitter_hashtag => params[:hashtag])
    end
  end

  private

  def scope_matches
    scoped = Match.all
    if params[:team_id].present?
      team_id = params[:team_id].to_i
      scoped = scoped.by_team_id(team_id)
    end
    scoped = scoped.order(:start_time)
    @matches = scoped
  end

end
