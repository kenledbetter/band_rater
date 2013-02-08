class AddDateToFestival < ActiveRecord::Migration
  def change
    change_table :festivals do |t|
      t.date :date
    end
  end
end
