class ChangeJokeCategories < ActiveRecord::Migration
  def change
    rename_table :jokes_categories, :joke_categories
  end
end
