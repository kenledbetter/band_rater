class ModifyBandAddPopularity < ActiveRecord::Migration
  def change
    change_table :bands do |t|
      t.decimal :popularity, :precision => 8, :scale => 5
    end
  end
end
