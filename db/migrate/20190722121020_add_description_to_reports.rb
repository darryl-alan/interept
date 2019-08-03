class AddDescriptionToReports < ActiveRecord::Migration[5.2]
  def change
    add_column :reports, :description, :text
    add_column :reports, :created_at, :datetime
    add_column :reports, :updated_at, :datetime
  end
end
