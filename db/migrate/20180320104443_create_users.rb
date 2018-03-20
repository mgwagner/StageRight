class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.text :email
      t.text :username
      t.text :password
      t.text :first_name
      t.text :last_name
      t.text :phone

      t.timestamps
    end
  end
end
