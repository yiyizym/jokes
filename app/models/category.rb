class Category < ActiveRecord::Base
  has_many :joke_categories, :dependent => :destroy
  has_many :jokes, :through => :joke_categories

  validates :content, presence: true

end