class MessagesController < ApplicationController
  MAX_MESSAGE_LENGTH = 1_000
  MAX_CONTEXT_MESSAGES = 10

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
    @message = @chat.messages.build(message_params)
    @message.role = "user"

    if @message.content.to_s.length > MAX_MESSAGE_LENGTH
      @message.errors.add(:content, "is too long")
      return render_message_form(:unprocessable_entity)
    end

    if @message.save
      response = RubyLLM.chat.with_instructions(instructions).ask(@message.content)
      @assistant_message = @chat.messages.create(role: "assistant", content: response.content)

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      render_message_form(:unprocessable_entity)
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end

  def render_message_form(status)
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "new_message_container",
          partial: "messages/form",
          locals: { chat: @chat, message: @message }
        ), status: status
      end

      format.html do
        render "chats/show", status: status
      end
    end
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
    [SYSTEM_PROMPT, character_context, conversation_context].join("\n\n")
  end

  def conversation_context
    previous_messages = @chat.messages
      .where.not(id: @message.id)
      .order(created_at: :desc)
      .limit(MAX_CONTEXT_MESSAGES)
      .reverse

    return "Conversation context: This is the first user message." if previous_messages.empty?

    transcript = previous_messages.map do |message|
      "#{message.role}: #{message.content}"
    end.join("\n")

    "Conversation context from the latest messages:\n#{transcript}"
  end
end
