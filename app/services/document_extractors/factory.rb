# frozen_string_literal: true

module DocumentExtractors
  # Factory to return the appropriate extractor based on content type
  class Factory
    MAPPING = {
      'text/plain' => DocumentExtractors::Text,
      'application/pdf' => DocumentExtractors::Pdf,
      'application/vnd.openxmlformats-officedocument.wordprocessingml.document' => DocumentExtractors::Docx
    }.freeze

    def self.for(content_type)
      MAPPING[content_type] || DocumentExtractors::Text
    end
  end
end
