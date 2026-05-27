class CharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_character, only: %i[show edit update destroy]

  def index
    @characters = Character.where(user: current_user).all
  end

  def show
    @chats = @character.chats.where(user: current_user).order(created_at: :desc)
  end

  def edit
  end

  def update
    if @character.update(character_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    @character.user = current_user

    begin
      @character.image_url = generated_character_image_url
    rescue RubyLLM::Error, RubyLLM::ConfigurationError, RubyLLM::ModelNotFoundError => e
      @character.errors.add(:base, "Image could not be generated: #{e.message}")
      return render :new, status: :unprocessable_entity
    end

    if @character.save
      redirect_to characters_path, notice: "Character Created Succefully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @character.destroy
    redirect_to characters_path, notice: "Character deleted."
  end

  private

  def set_character
    @character = current_user.characters.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :personality, :role, :gender, :race, :history)
  end

  def generated_character_image_url
    image = RubyLLM.paint(character_image_prompt)

    return image.url if image.url.present?
    return "data:#{image.mime_type || "image/png"};base64,#{image.data}" if image.data.present?
  end

  def character_image_prompt
    <<~PROMPT
      Create a fantasy character portrait.

      Character details:
      Name: #{@character.name}
      Race: #{@character.race}
      Role: #{@character.role}
      Gender: #{@character.gender}
      Personality: #{@character.personality}
      History: #{@character.history}

      Style: high quality fantasy RPG character portrait, detailed, atmospheric, centered composition.
      Do not include text, logos, UI, captions, or watermarks.
    PROMPT
  end
end
