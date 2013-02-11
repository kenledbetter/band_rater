class ModifyBandLocationUrl < ActiveRecord::Migration
  def change
    change_table :bands do |t|
      t.string :location
      t.string :url
    end
  end
end
