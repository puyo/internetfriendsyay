class AddScheduleIdIndex < ActiveRecord::Migration[4.2]
  def up
    add_index :people, :schedule_id
  end

  def down
    remove_index :people, :schedule_id
  end
end
