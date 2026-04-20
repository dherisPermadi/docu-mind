# frozen_string_literal: true

module Knowledge
  # Processor to handle document extraction, sanitization, chunking, and vector simulation for search
  class Processor
    def self.call(document, file_object)
      extractor = DocumentExtractors::Factory.for(file_object.content_type)
      raw_content = extractor.extract(file_object.path)
      clean_text = sanitize(raw_content)

      pieces = if structured_file?(file_object.content_type)
                 clean_text.split(/\n{2,}/).map(&:strip).reject(&:blank?)
               else
                 clean_text.split("\n").map(&:strip).reject(&:blank?)
               end

      save_chunks(document, pieces)
    end

    def self.sanitize(text)
      text.encode('UTF-8', invalid: :replace, undef: :replace, replace: '')
          .gsub("\u0000", '')
          .gsub(/[ \t]+/, ' ')
    end

    def self.structured_file?(content_type)
      ['application/pdf',
       'application/vnd.openxmlformats-officedocument.wordprocessingml.document'].include?(content_type)
    end

    def self.save_chunks(document, pieces)
      pieces.each do |piece|
        word_map = piece.downcase.gsub(/[^a-z0-9\s]/i, ' ').split.tally

        document.chunks.create!(
          content: piece,
          vector_sim: word_map
        )
      end
    end
  end
end
