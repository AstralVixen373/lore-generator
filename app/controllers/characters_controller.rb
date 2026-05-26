class CharactersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_character, only: [:edit, :update]

  def index
    @characters = Character.all
  end

  def show
    @character = Character.find(params[:id])
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
    if @character.save
      redirect_to characters_path, notice: "Character Created Succefully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_character
    @character = current_user.characters.find(params[:id])
  end

  def character_params
    params.require(:character).permit(:name, :personnality, :role, :gender, :race, :history)
  end
end
