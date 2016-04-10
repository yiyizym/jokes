namespace :batch do
  desc "set trash joke, batch operation"
  task :set_trash => :environment do
    Joke.where("point = ? and trash = ?", 0, false).update_all(trash: true)

  end
end