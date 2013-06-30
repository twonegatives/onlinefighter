class RemoveWonFromCharacter < ActiveRecord::Migration
  def up
    remove_column :characters, :won
  end

  def down
    add_column :characters, :won, :integer
  end
end
