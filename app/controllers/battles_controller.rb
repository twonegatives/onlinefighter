class BattlesController < ApplicationController
  def create
    fighter1      = current_user.character.id
    fighter2      = params[:enemy_id].to_i
    battle        = Battle.new(:fighter1_id => fighter1, :fighter2_id => fighter2, :winner_id => [fighter1, fighter2].sample(1).first)
    text          = if battle.save
                      ['notice=', battle.winner_id == fighter1 ? 'You have just won a round!' : 'You have lost this round...']
                    else
                      ['alert=', battle.errors.full_messages.join(', ')]
                    end
    flash.send(text.first, text.last)
    redirect_to characters_dashboard_path
  end
end
