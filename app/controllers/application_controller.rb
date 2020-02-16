class ApplicationController < ActionController::API
  acts_as_token_authentication_handler_for User, fallback: :none

  before_action :authenticate_user_from_token!, unless: :login

  before_action :authenticate_user!, unless: :login


  def authenticate_user_from_token!
    user_token = params[:user_token].presence || request.headers["X-User-Token"]
    user       = user_token && User.find_by_authentication_token(user_token.to_s)
    

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end

  def login 
    request.path == "/api/v1/sessions" && request.request_method == "POST"
  end 

end
