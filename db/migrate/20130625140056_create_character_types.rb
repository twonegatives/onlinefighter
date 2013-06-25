class CreateCharacterTypes < ActiveRecord::Migration
  def change
    create_table :character_types do |t|
      t.integer :max_health
      t.integer :attack
      t.integer :defence
      t.integer :magic
      t.string  :name

      t.timestamps
    end
  end
end
