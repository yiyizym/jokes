class AddPublishedToJokes < ActiveRecord::Migration
  def change
    add_column :jokes, :published, :boolean, default: false
  end
end
