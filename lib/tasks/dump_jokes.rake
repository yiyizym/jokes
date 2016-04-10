# usage rake data:dump filename=yourfile
namespace :data do
  desc "dump data from db to json file"
  task :dump => :environment do
    p "dump to file #{ENV['filename']}"
    File.open Rails.root.join('lib', 'tasks', "#{ENV['filename']}"),'w' do |file|
      content = Joke.where(trash: false).limit(10).to_json
      file.write(content)
    end
  end
end
