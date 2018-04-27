class AddCuesInformationToNotes < ActiveRecord::Migration[5.1]
  def change
  	add_column :notes, :cueType, :text
  	add_column :notes, :cueLabel, :text
  	add_column :notes, :cueDescription, :text
  	remove_column :notes, :note_content
  end
end
