class AddWonBattlesCountToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :won_battles_count, :integer
  end
end
