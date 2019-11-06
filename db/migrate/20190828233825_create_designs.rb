class CreateDesigns < ActiveRecord::Migration[5.2]
  def change
    create_table :designs do |t|
      t.integer "project_id"
      t.column "designer_name", :string, :limit => 50
      t.column "designer_last_name", :string, :limit => 50
      t.column "designer_email", :string, :limit => 50
      t.column "price", :float, :default => 0
      t.column "is_available", :boolean, :default => false
      t.timestamps
    end

    add_index("designs", "project_id")
  end
end
