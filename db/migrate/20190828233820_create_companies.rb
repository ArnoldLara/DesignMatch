class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.column "name", :string
      t.column "last_index", :int, :default => 0
      t.timestamps
    end
    add_index :companies, :name
  end
end
