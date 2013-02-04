class AddAverageRatingToBand < ActiveRecord::Migration
  def change
    change_table :bands do |t|
      t.decimal :average_rating, :scale => 2, :precision => 3
    end
  end
end
