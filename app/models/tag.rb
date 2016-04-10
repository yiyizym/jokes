class Tag < ActiveRecord::Base
  has_many :joke_tags, :dependent => :destroy
  has_many :jokes, :through => :joke_tags

  validates :content, presence: true

end
