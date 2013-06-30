class CreateBattles < ActiveRecord::Migration
  def change
    create_table :battles do |t|
      t.integer :fighter1_id
      t.integer :fighter2_id
      t.integer :winner_id

      t.timestamps
    end
  end
end
