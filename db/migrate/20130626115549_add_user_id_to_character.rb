class AddUserIdToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :user_id, :integer
  end
end
