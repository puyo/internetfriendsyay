class AddScheduleIdIndex < ActiveRecord::Migration
  def up
    add_index :people, :schedule_id
  end

  def down
    remove_index :people, :schedule_id
  end
end
