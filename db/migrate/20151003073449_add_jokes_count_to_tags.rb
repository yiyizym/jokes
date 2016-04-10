class AddJokesCountToTags < ActiveRecord::Migration
  def change
    add_column :tags, :jokes_count, :integer
  end
end
