class JokeCategories < ActiveRecord::Base
  belongs_to :joke
  belongs_to :category
end