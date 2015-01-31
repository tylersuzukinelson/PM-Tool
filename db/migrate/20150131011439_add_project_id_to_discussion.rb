class AddProjectIdToDiscussion < ActiveRecord::Migration
  def change
  	add_column :discussions, :project_id, :integer
  end
end
