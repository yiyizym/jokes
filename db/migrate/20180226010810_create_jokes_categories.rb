class CreateJokesCategories < ActiveRecord::Migration
  def change
    create_table :jokes_categories do |t|
      t.belongs_to :joke, index: true
      t.belongs_to :category, index: true
    end
  end
end
