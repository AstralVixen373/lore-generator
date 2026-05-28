class GenerateCharacterImageJob < ApplicationJob
  queue_as :default

  def perform(character_id)
    Rails.logger.info "JOB STARTED"

    character = Character.find(character_id)

    image = RubyLLM.paint(
      character_image_prompt(character)
    )

    Rails.logger.info "IMAGE GENERATED"

    character.update!(image_url: "data:image/png;base64,#{image.data}")
    
    Rails.logger.info "ERRORS #{character.errors.full_messages}"
    
    Rails.logger.info "JOB FINISHED"
  end

  private

  def character_image_prompt(character)
    <<~PROMPT
      Create a fantasy character portrait.

      Character details:
      Name: #{character.name}
      Race: #{character.race}
      Role: #{character.role}
      Gender: #{character.gender}
      Personality: #{character.personality}
      Description: #{character.history}

      Style: high quality fantasy RPG character portrait, detailed, atmospheric, centered composition.
      Do not include text, logos, UI, captions, or watermarks.
    PROMPT
  end
end
