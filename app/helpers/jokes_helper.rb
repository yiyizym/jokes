module JokesHelper
  def joke_tags(joke)
    joke.tags.map do |tag|
      tag.content
    end.join(",")
  end

  def joke_categories(joke)
    joke.categories.map do |category|
      category.content
    end.join(",")
  end

  def all_tags
    Tag.all
  end

  def all_categories
    Category.all
  end
end