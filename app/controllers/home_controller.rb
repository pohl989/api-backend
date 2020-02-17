class HomeController < ApplicationController
  before_action :skip_authorization, only: :welcome

  def index
  end

  def minor
  end

  def welcome
    unless current_user
      redirect_to sign_in_path
    end
  end

end
