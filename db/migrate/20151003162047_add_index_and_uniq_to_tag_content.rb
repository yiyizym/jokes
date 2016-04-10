class AddIndexAndUniqToTagContent < ActiveRecord::Migration
  def change
    add_index :tags, :content, :unique => true
  end
end
