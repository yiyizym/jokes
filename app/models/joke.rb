class Joke < ActiveRecord::Base
  has_many :joke_tags, :dependent => :destroy
  has_many :tags, :through => :joke_tags

  validates_presence_of :content

  private



end
