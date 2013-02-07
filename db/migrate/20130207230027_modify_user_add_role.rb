class ModifyUserAddRole < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.boolean :admin, :default => false
      t.boolean :featured, :default => false
    end
  end
end
