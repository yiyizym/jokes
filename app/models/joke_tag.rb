class JokeTag < ActiveRecord::Base
  belongs_to :joke
  belongs_to :tag
end
