# usage rake data:dump_modified point=yourpoint published=true
namespace :data do
  desc "dump modified jokes from db to json file"
  task :dump_modified => :environment do

    file = File.open("#{Rails.root.join('lib', 'tasks', 'dump.log')}", File::WRONLY | File::APPEND)
    logger = Logger.new(file)
    filename = "dump_modified_jokes"
    point = ENV['point'] || 6
    published = ENV['published'] || 'true'
    p "dump to file #{filename}.json, where point greater than or equal #{point} and published #{published} and been modified."
    begin
      logger.debug "fetching jokes where have been modified and point greater than or equal #{point} and published #{published}\n"
      content = Joke.where(trash: false).where('point >= ? and published = ?',point, published == 'true')
      content = content.where('created_at != updated_at')
      if content.count == 0
        logger.debug "no jokes to dump\n"
      else
        logger.debug "dump #{content.count} jokes into file #{filename}.json\n"
        File.open Rails.root.join('lib', 'tasks/output', "#{filename}.json"),'w' do |file|
          file.write(content.to_json)
          logger.debug "dump to file success \n"
        end
      end
    rescue IOError => e
      logger.error "dump to file failed! \n error: #{e}\n"
    end
  end
end
