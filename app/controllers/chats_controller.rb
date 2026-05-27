class ChatsController < ApplicationController
  before_action :authenticate_user!

  def create
    @character = current_user.characters.find(params[:character_id])
    @chat = Chat.new(character: @character, user: current_user)

    if @chat.save
      redirect_to chat_path(@chat)
    else
      redirect_to character_path(@character), alert: "Chat could not be created."
    end
  end

  def show
    @chat = current_user.chats.find(params[:id])
    @message = Message.new
  end

  def destroy
    @chat = current_user.chats.find(params[:id])
    @character = @chat.character
    @chat.destroy

    redirect_to character_path(@character), notice: "Chat deleted."
  end
end
