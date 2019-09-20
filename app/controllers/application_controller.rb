class ApplicationController < ActionController::API


  before_action :verify_auth_token!, :if => proc { Rails.env.production? }
  after_action :track_call, :if => proc { Rails.env.production? }



  def verify_auth_token!
    if request_auth_token
      if AuthenticationUser.exists?(:api_auth_token => request_auth_token)
        @current_user = AuthenticationUser.find_by_api_auth_token(request_auth_token)
      else
        render json: { error: "auth_not_found", message: "Could not find user with auth given" }.to_json, status: 401
      end
    else
      render json: { error: "missing_auth", message: "Missing Auth Token in Header" }.to_json, status: 401
    end
  end

  def request_auth_token
    request.headers["X-API-Auth-Token"]
  end

  def track_call
    @current_user.update_columns(:last_requested => Time.now, :requested_count => @current_user.requested_count.to_i+1)
  end

end
