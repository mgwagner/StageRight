class CreateScripts < ActiveRecord::Migration[5.1]
  def change
    create_table :scripts do |t|
      t.text :script_name
      t.integer :user_id

      t.timestamps
    end
  end
end
