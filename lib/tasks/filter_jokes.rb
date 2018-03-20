require 'json'

# read all already haven jokes

# batch read new jokes if 

already_jokes = []
['data','201606181727','201607301223','201803030901'].each do |filename|

  File.open File.join(File.dirname(__FILE__), 'output', "#{filename}.json"),"r" do |file|

    jokes = JSON.parse(file.read)
    p "jokes count: #{jokes.length}"

    filter_jokes = []
    jokes.each do |new_joke|
      already = false
      already_jokes.each do |old_joke|
        unless new_joke["created_at"].nil?
          already = true if new_joke["created_at"] == old_joke["created_at"]
        else
          already = true if new_joke["content"][0,10] == old_joke["content"][0,10]
        end
      end
      filter_jokes.push(new_joke) unless already
    end

    p "filter_jokes count: #{filter_jokes.length}"
    already_jokes.concat(filter_jokes)
    p "already_jokes count: #{already_jokes.length}"
  end

end

File.open File.join(File.dirname(__FILE__), 'output', "201803031030.json"),"r" do |file|
  jokes = JSON.parse(file.read)
  p "jokes count: #{jokes.length}"

  filter_jokes = []
  repeatted_jokes = []
  jokes.each do |new_joke|
    already = false
    already_jokes.each do |old_joke|
      unless (new_joke["created_at"].nil? || old_joke["created_at"].nil?)
        already = true if new_joke["created_at"] == old_joke["created_at"]
      else
        already = true if new_joke["content"][0,10] == old_joke["content"][0,10]
      end
    end
    unless already
      filter_jokes.push(new_joke)
    else
      repeatted_jokes.push(new_joke)
    end
      
  end

  p "filter_jokes count: #{filter_jokes.length}"
  p "repeatted_jokes count: #{repeatted_jokes.length}"

  File.open(File.join(File.dirname(__FILE__), 'output', "filtered.json"),mode: 'w:UTF-8') do |file|
    file.write(filter_jokes.to_json)
  end

  File.open(File.join(File.dirname(__FILE__), 'output', "repeatted.json"),mode: 'w:UTF-8') do |file|
    file.write(repeatted_jokes.to_json)
  end

end
