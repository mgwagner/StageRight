class AddLocationOfCueToNotes < ActiveRecord::Migration[5.1]
  def change
  	add_column :notes, :lineNum, :integer
  	add_column :notes, :location, :integer
  end
end
