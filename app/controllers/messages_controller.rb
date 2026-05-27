class MessagesController < ApplicationController
  SYSTEM_PROMPT = <<~PROMPT
    You are a fantasy character roleplay assistant.

    The user is chatting with a fictional character they created.

    Answer as the character, using the character context. Stay immersive, concise, and helpful.

    Answer in Markdown.
  PROMPT

  before_action :authenticate_user!

  def create
    @chat = current_user.chats.find(params[:chat_id])
    @character = @chat.character
    @message = Message.new(message_params)
    @message.chat = @chat
    @message.role = "user"

    if @message.save
      response = RubyLLM.chat.with_instructions(instructions).ask(@message.content)
      Message.create(role: "assistant", content: response.content, chat: @chat)

      redirect_to chat_path(@chat)
    else
      render "chats/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def character_context
    <<~CONTEXT
      Character context:
      Name: #{@character.name}
      Race: #{@character.race}
      Role: #{@character.role}
      Gender: #{@character.gender}
      Personality: #{@character.personality}
      History: #{@character.history}
    CONTEXT
  end

  def instructions
    [SYSTEM_PROMPT, character_context].join("\n\n")
  end
end
