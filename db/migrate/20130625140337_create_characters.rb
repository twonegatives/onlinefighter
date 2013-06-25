class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.integer :character_type_id
      t.integer :health
      t.integer :experience,  :default => 0
      t.integer :won,         :default => 0
      t.integer :lost,        :default => 0
      t.integer :defence
      t.integer :attack
      t.integer :magick

      t.timestamps
    end
  end
end
