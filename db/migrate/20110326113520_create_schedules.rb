class CreateSchedules < ActiveRecord::Migration
  def self.up
    create_table :schedules do |t|
      t.references :user
      t.references :group
      t.binary :data, :limit => 84

      t.timestamps
    end
  end

  def self.down
    drop_table :schedules
  end
end
