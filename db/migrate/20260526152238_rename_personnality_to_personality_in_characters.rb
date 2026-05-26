class RenamePersonnalityToPersonalityInCharacters < ActiveRecord::Migration[8.1]
  def change
    rename_column :characters, :personnality, :personality
  end
end
