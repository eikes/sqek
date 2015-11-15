class PublishAllSquats < ActiveRecord::Migration
  def up
    Squat.update_all(published: true)
  end
  def down
    Squat.update_all(published: false)
  end
end
