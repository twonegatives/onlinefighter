class CharactersController < ApplicationController

  before_filter :redirect_to_new_unless_character, :only => [:dashboard, :destroy]
  before_filter :redirect_to_new_unless_choose, :only => :choose
  before_filter :redirect_to_dashboard_if_character_exists, :only => :choose
  before_filter :redirect_to_root_unless_signed_in, :only => :new

  def new
    @character_types = CharacterType.all
  end

  def destroy
    current_user.character.destroy
    redirect_to root_path
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
    @character        = Character.where(:user_id => current_user.id).includes(:items).first
    if @character.battles.count == 5
      @share = ['http://127.0.0.1:3000/', 'AWESOME!']
      render 'share_with_friends'
    else
      had_battles_with = @character.battles.all.map{|i| [i.fighter1_id, i.fighter2_id]}.flatten.uniq
      had_battles_with = [current_user.character.id] if had_battles_with.blank?
      @enemies = Character.where('id NOT IN (?)', had_battles_with).includes(:character_type).limit(5).all
      render 'dashboard'
    end
  end

  private

  def redirect_with_error text, redirect_path
    flash.alert = text
    redirect_to redirect_path
  end

  def redirect_to_root_unless_signed_in
    redirect_with_error('You should sign in to create a character', root_path) unless current_user
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
