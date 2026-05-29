class CharactersController < ApplicationController
  MAX_MESSAGE_LENGTH = 1_000
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
      redirect_to character_path(@character)
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
      @character.backstory = generated_character_backstory
    rescue RubyLLM::Error, RubyLLM::ConfigurationError, RubyLLM::ModelNotFoundError => e
      @character.errors.add(:base, "Backstory could not be generated: #{e.message}")
      return render :new, status: :unprocessable_entity
    end

    if @character.save
      GenerateCharacterImageJob.perform_later(@character.id)

      redirect_to character_path(@character),
                  notice: "Character Created Successfully!"
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

  def generated_character_backstory
    chat = RubyLLM.chat
    response = chat.ask(character_backstory_prompt)
    response.content
  end

  def character_backstory_prompt
    <<~PROMPT
      Create a fantasy character backstory in a few lines

      Generate ONLY a fictional backstory paragraph IN FRENCH.

      Do NOT repeat the character sheet.
      Do NOT include labels like Name:, Race:, Role:, Gender:, Personality: or Description: in the generated paragraph.

      Character details:
      Name: #{@character.name}
      Race: #{@character.race}
      Role: #{@character.role}
      Gender: #{@character.gender}
      Personality: #{@character.personality}
      History: #{@character.history}

      Style: detailed, atmospheric, rich narrative.
    PROMPT
  end
end
