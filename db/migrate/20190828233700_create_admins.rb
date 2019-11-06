class CreateAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :admins do |t|
      t.column "company", :string, :limit => 50
      t.column "url", :string, :limit => 50
      t.column "email", :string, :limit => 50
      t.column "password", :string, :limit => 50
      t.timestamps
    end
  end
end
