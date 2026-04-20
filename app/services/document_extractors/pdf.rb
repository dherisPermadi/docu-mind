# frozen_string_literal: true

require 'pdf-reader'
module DocumentExtractors
  # Extractor for PDF files using the 'pdf-reader' gem
  class Pdf
    def self.extract(file_path)
      PDF::Reader.new(file_path).pages.map(&:text).join("\n")
    end
  end
end
