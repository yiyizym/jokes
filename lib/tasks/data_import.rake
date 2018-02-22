namespace :data do
  desc "import data from json files to database"
  task :import => :environment do
    p "Importing file  #{ENV['filename']}"
    require 'json'
    File.open Rails.root.join('lib', 'tasks', "#{ENV['filename']}"),"r" do |file|
      file.each do |line|
        data_hash = JSON.parse(line)
        data_array = data_hash["result"]["content"]
        data_array.reject do |record|
          record.include?('在大作中提到')
        end
        data_array.each do |record|
          # p record
          Joke.create({content: record})
        end
      end
    end
  end
  task :import_json => :environment do
    p "Importing file #{ENV['filename']}"
    require 'json'
    File.open Rails.root.join('lib', 'tasks', "#{ENV['filename']}"), "r" do |file|
      data_array = JSON.parse(file.read)
      data_array.each do |item|
        Joke.create({content: item['content'], published: true}) if item['content'].present?
      end
    end
  end
end
