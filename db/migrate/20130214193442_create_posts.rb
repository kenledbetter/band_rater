class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.references :festival

      t.timestamps
    end
    add_index :posts, :festival_id
  end
end
