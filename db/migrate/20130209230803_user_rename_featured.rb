class UserRenameFeatured < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.rename :featured, :reviewer
    end
  end
end
