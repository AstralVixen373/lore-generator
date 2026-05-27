class AddImageUrlToCharacters < ActiveRecord::Migration[8.1]
  def change
    add_column :characters, :image_url, :text
  end
end
