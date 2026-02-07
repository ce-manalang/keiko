class CreateShifts < ActiveRecord::Migration[8.1]
  def change
    create_table :shifts do |t|
      t.references :user, null: false, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :acknowledged
      t.text :notes

      t.timestamps
    end
  end
end
