# frozen_string_literal: true

module DocumentExtractors
  # Extractor for plain text files
  class Text
    def self.extract(file_path)
      File.read(file_path).force_encoding('UTF-8')
    end
  end
end
