class AddDefaultValueToCharactersWonBattlesCount < ActiveRecord::Migration
  def up
    change_column_default :characters, :won_battles_count, 0
  end
  def down
    change_column_default :characters, :won_battles_count, nil
  end
end
