class ApplicationController < ActionController::Base
  protect_from_forgery

  def welcome
    if current_user
      if current_user.character.present?
        redirect_to characters_dashboard_path
      else
        redirect_to characters_new_path
      end
    end
  end

end
