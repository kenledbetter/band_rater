class UpdatePostAddPublishedUser < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.boolean :publish, :default => false
      t.integer :user_id
    end
  end
end
