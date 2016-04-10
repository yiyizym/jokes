class CreateJokeTags < ActiveRecord::Migration
  def change
    create_table :joke_tags do |t|
      t.integer :joke_id
      t.integer :tag_id

      t.timestamps null: false
    end
  end
end
