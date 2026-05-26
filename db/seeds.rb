# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Cleaning database..."
Message.destroy_all
Chat.destroy_all
Character.destroy_all
User.destroy_all

puts "Creating user..."
user = User.create!(
  email: "test@example.com",
  password: "password"
)

puts "Creating characters..."
character = Character.create!(
  user: user,
  name: "Kael",
  personality: "Courageux, loyal, mystérieux",
  race: "Elf",
  role: "Mage",
  gender: "Male",
  history: "Kael vient d'une ancienne cité oubliée."
)

puts "Creating chat..."

chat = Chat.create!(
  user: user,
  character: character
)

puts "Creating messages..."

Message.create!(
  chat: chat,
  role: "user",
  content: "Bonjour Kael, raconte-moi ton histoire."
)

Message.create!(
  chat: chat,
  role: "assistant",
  content: "Je viens d'une cité cachée entre les montagnes."
)

puts "Seed finished!"
