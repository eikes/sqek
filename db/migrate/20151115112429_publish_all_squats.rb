class PublishAllSquats < ActiveRecord::Migration[4.2]
  def up
    Squat.update_all(published: true)
  end
  def down
    Squat.update_all(published: false)
  end
end
