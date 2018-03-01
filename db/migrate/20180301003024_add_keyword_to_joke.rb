class AddKeywordToJoke < ActiveRecord::Migration
  def change
    add_column :jokes, :keyword, :string, default: ''
  end
end
