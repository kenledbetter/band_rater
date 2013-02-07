class ModifyUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :name
      t.text :description
    end
  end
end
