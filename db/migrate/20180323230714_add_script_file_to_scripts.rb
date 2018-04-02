class AddScriptFileToScripts < ActiveRecord::Migration[5.1]
  def change
  	add_column :scripts, :filename, :text
  end
end
