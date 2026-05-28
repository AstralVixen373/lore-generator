class AddBackstoryToCharacters < ActiveRecord::Migration[8.1]
  def change
    add_column :characters, :backstory, :text
  end
end
