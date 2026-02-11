class AddEmployeeNotesToShifts < ActiveRecord::Migration[8.1]
  def change
    add_column :shifts, :employee_notes, :text
  end
end
