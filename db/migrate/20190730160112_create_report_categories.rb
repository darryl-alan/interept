class CreateReportCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :report_categories do |t|
      t.integer :report_id
      t.integer :category_id
      t.timestamps
    end
  end
end
