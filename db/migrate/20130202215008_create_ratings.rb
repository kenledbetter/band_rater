class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :rating
      t.references :band
      t.references :user

      t.timestamps
    end
    add_index :ratings, :band_id
    add_index :ratings, :user_id
  end
end
