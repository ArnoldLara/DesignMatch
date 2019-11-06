class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.integer "admin_id"
      t.column "name", :string, :limit => 100
      t.column "description", :text
      t.column "price", :float, :default => 0
      t.timestamps
    end

    add_index("projects", "admin_id")

  end
end
