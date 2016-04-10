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
end