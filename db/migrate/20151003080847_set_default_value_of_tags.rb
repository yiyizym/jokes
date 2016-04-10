class SetDefaultValueOfTags < ActiveRecord::Migration
  def change
    change_column :tags, :jokes_count, :integer, default: 0
  end
end
