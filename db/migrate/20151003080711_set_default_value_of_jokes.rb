class SetDefaultValueOfJokes < ActiveRecord::Migration
  def change
    change_column :jokes, :point, :integer, default: 0
  end
end
