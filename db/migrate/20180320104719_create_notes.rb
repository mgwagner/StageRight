class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.integer :script_id
      t.integer :user_id
      t.text :note_content

      t.timestamps
    end
  end
end
