class BandsFestivalsJoinTable < ActiveRecord::Migration
  def change
    create_table :bands_festivals, :id => false do |t|
      t.integer :band_id
      t.integer :festival_id
    end
  end
end
