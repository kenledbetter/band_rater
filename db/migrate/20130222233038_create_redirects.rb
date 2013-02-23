class CreateRedirects < ActiveRecord::Migration
  def change
    create_table :redirects do |t|
      t.string :source
      t.string :destination
      t.timestamps
    end
  end
end
