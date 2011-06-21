class AddScheduleIdIndex < ActiveRecord::Migration
  def self.up
    add_index :people, :schedule_id
  end

  def self.down
    remove_index :people, :schedule_id
  end
end
