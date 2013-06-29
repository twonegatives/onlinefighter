class CharactersController < ApplicationController

  before_filter :redirect_to_new_unless_character, :only => :dashboard
  before_filter :redirect_to_new_unless_choose, :only => :choose
  before_filter :redirect_to_dashboard_if_character_exists, :only => :choose

  def new
    @character_types = CharacterType.all
  end

  def choose
    current_user.build_character(:character_type_id => params[:id].to_i)
    if current_user.save
      flash.notice = 'Character created successfully!'
      redirect_to characters_dashboard_path
    else
      flash.error = 'Could not create a character due some reasons...'
      redirect_to new_character_path
    end
  end

  def dashboard
  end

  private

  def redirect_with_error text, redirect_path
    flash.alert = text
    redirect_to redirect_path
  end

  def redirect_to_new_unless_character
    redirect_with_error('You should create a character firstly.', new_character_path) unless current_user.try(:character).present?
  end

  def redirect_to_new_unless_choose
    redirect_with_error('You should select a character to play.', new_character_path) unless params[:id]
  end

  def redirect_to_dashboard_if_character_exists
    redirect_with_error('You already have a character.', characters_dashboard_path) if current_user.try(:character).present?
  end

end
