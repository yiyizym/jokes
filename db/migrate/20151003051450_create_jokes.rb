class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.string :content
      t.integer :point

      t.timestamps null: false
    end
  end
end
