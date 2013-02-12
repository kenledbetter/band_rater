class CreateLineups < ActiveRecord::Migration
  def change
    create_table :lineups do |t|
      t.references :band
      t.references :festival

      t.timestamps
    end
    add_index :lineups, :band_id
    add_index :lineups, :festival_id
  end
end
