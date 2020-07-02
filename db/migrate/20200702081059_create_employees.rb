class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :first_name, :limit => 100, :null => false
      t.string :last_name, :limit => 100, :null => false
      t.string :email, :limit => 100, :null => true 
      t.string :phone, :limit => 100, :null => true
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
