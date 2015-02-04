class AddCompleteStatusToTask < ActiveRecord::Migration
  def change
  	add_column :tasks, :completed_status, :boolean, default: :false
  end
end
