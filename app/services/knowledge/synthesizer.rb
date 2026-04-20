# frozen_string_literal: true

# app/services/knowledge/synthesizer.rb
module Knowledge
  # Synthesizer to generate a concise answer based on relevant chunks
  class Synthesizer
    def self.generate_answer(relevant_chunks)
      return 'Sorry, No relevant information found in the documents.' if relevant_chunks.empty?

      intro = "Based on the analyzed document, there are #{relevant_chunks.size} references related to this topic:"
      body = relevant_chunks.map(&:content).join("\n\n")

      "#{intro}\n\n#{body}"
    end
  end
end
