# frozen_string_literal: true

require 'docx'
module DocumentExtractors
  # Extractor for DOCX files using the 'docx' gem
  class Docx
    def self.extract(file_path)
      doc = ::Docx::Document.open(file_path)
      doc.paragraphs.map(&:to_s).join("\n")
    end
  end
end
