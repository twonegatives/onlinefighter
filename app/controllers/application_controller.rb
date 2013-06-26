class ApplicationController < ActionController::Base
  protect_from_forgery

  def welcome
    @user = current_user
  end

end
