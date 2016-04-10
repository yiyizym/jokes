module JokesHelper
  def joke_tags(joke)
    joke.tags.map do |tag|
      tag.content
    end.join(",")
  end
end