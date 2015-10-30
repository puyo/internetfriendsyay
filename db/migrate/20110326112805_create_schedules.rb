class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.string :uuid, :null => false
      t.timestamps null: false
    end
  end

  def self.down
    drop_table :schedules
  end
end
