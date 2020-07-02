class CreateCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :companies do |t|
      t.string :name, :limit => 100, :null => false
      t.string :email, :limit => 100, :null => true
      t.string :logo, :limit => 100, :null => true
      t.string :website, :limit => 100, :null => true

      t.timestamps
    end
  end
end
