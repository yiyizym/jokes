class Joke < ActiveRecord::Base
  has_many :joke_tags, :dependent => :destroy
  has_many :tags, :through => :joke_tags

  has_many :joke_categories, :dependent => :destroy
  has_many :categories, :through => :joke_categories

  validates_presence_of :content

  scope :not_trashed, -> { where(trash: false) }

  def self.search(params)
    jokes = Joke.not_trashed
    case params[:type]
    when 'content'
      jokes = jokes.where("content LIKE ?", "%#{params[:content]}%")
    when 'point'
      jokes = jokes.where("point = ?", params[:content])
    when 'keyword'
      jokes = jokes.where("keyword LIKE ?", "%#{params[:content]}%")
    when 'category'
      jokes = jokes.joins(:categories).where(categories: {content: params[:content]})
    when 'tag'
      jokes = jokes.joins(:tags).where(tags: {content: params[:content]})
    end
    jokes.order(created_at: :desc).page(params[:page])
  end

end
