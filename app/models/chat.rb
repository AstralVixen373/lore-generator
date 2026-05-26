class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :character
  has_many :messages, dependent: :destroy
end
