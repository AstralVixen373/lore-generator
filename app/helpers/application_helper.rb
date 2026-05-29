module ApplicationHelper
  CHARACTER_TRANSLATIONS = {
    race: {
      "Human" => "Humain",
      "Elf" => "Elfe",
      "Dwarf" => "Nain",
      "Orc" => "Orc",
      "Half-elf" => "Demi-elfe",
      "Draconians" => "Draconien"
    },
    role: {
      "Thief" => "Voleur",
      "Warrior" => "Guerrier",
      "Spellcaster" => "Mage",
      "Ranger" => "Rôdeur",
      "Cleric" => "Clerc",
      "Bard" => "Barde"
    },
    gender: {
      "Male" => "Homme",
      "Female" => "Femme",
      "Non-binary" => "Non-binaire",
      "Other" => "Autre"
    },
    personality: {
      "Cold, cunning & independant" => "Froid, rusé et indépendant",
      "Brave & loyal" => "Brave et loyal",
      "Mysterious" => "Mystérieux",
      "Chaotic" => "Chaotique",
      "Wise" => "Sage"
    }
  }.freeze

  def character_display_value(attribute, value, fallback: "Non renseigné")
    return fallback if value.blank?

    CHARACTER_TRANSLATIONS.fetch(attribute.to_sym, {}).fetch(value, value)
  end
end
