class CreatePeople < ActiveRecord::Migration[4.2]
  def up
    create_table :people do |t|
      t.references :schedule
      t.string :name, null: false
      t.string :timezone, null: false
      t.binary :data
      t.timestamps null: false
    end
  end

  def down
    drop_table :people
  end
end
