# usage rake data:dump point=yourpoint published=false
namespace :data do
  desc "dump data from db to json file"
  task :dump => :environment do

    file = File.open("#{Rails.root.join('lib', 'tasks', 'dump.log')}", File::WRONLY | File::APPEND)
    logger = Logger.new(file)
    filename = Time.now().strftime('%Y%m%d%H%M')
    point = ENV['point'] || 6
    published = ENV['published'] || 'false'
    p "dump to file #{filename}.json, where point greater than or equal #{point} and published #{published}"
    begin
      logger.debug "fetching jokes where point greater than or equal #{point} and published #{published}\n"
      content = Joke.where(trash: false).where('point >= ? and published = ?',point, published == 'true')
      if content.count == 0
        logger.debug "no jokes to dump\n"
      else
        logger.debug "dump #{content.count} jokes into file #{filename}.json\n"
        File.open Rails.root.join('lib', 'tasks/output', "#{filename}.json"),'w' do |file|
          file.write(content.to_json)
          logger.debug "dump to file success \n"
          content.update_all(published: true)
          logger.debug "update jokes' status to published\n"
        end
      end
    rescue IOError => e
      logger.error "dump to file failed! \n error: #{e}\n"
      if content.count != 0
        logger.debug "reset jokes' status to unpublished\n"
        content.update_all(published: false)
      else
        logger.debug "no jokes to reset status to unpublished\n"
      end
    end
  end
end
