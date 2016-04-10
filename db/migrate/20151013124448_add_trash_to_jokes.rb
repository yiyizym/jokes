class AddTrashToJokes < ActiveRecord::Migration
  def change
    add_column :jokes, :trash, :boolean, default: false
  end
end
