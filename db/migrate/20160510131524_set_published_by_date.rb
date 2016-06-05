class SetPublishedByDate < ActiveRecord::Migration
  def up
    Joke.where('point >= ? and created_at <= ?', '6', '2016-04-22 07:36:00').update_all(published: true);
  end
  def down
    Joke.where('point >= ? and created_at <= ?', '6', '2016-04-22 07:36:00').update_all(published: false);
  end
end
