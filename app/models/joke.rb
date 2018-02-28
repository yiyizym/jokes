class Joke < ActiveRecord::Base
  has_many :joke_tags, :dependent => :destroy
  has_many :tags, :through => :joke_tags

  has_many :joke_categories, :dependent => :destroy
  has_many :categories, :through => :joke_categories

  validates_presence_of :content

end
