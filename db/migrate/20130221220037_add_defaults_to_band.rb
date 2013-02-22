class AddDefaultsToBand < ActiveRecord::Migration
  def up
    change_column :bands, :average_rating, :decimal, :precision => 3, :scale => 2, :default => 0
    change_column :bands, :popularity, :decimal, :precision => 8, :scale => 5, :default => 0
  end

  def down
    change_column :bands, :average_rating, :decimal, :precision => 3, :scale => 2
    change_column :bands, :popularity, :decimal, :precision => 8, :scale => 5
  end
end
