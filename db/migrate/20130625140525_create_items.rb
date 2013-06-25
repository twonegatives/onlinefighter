class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :character_type_id
      t.integer :increasable_id
      t.integer :increase_value
      t.integer :character_id
      t.integer :item_type_id
      t.boolean :is_equipped, :default => false

      t.timestamps
    end
  end
end
