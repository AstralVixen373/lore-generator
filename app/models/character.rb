class Character < ApplicationRecord
  belongs_to :user
  has_many :chats, dependent: :destroy

  after_update_commit -> {
    broadcast_replace_to(
      "character_#{id}",
      target: "character_image",
      partial: "characters/image",
      locals: { character: self }
    )
  }
end
