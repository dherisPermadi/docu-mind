# frozen_string_literal: true

module Knowledge
  # Service to search for relevant chunks based on a query
  class Searcher
    def self.call(query_text)
      query_map = query_text.downcase.gsub(/[^\w\s]/, '').split.tally
      scores = similarity_scores(query_map)

      top_chunk_ids = scores.sort_by { |_id, score| -score }.first(3).map(&:first)
      Chunk.where(id: top_chunk_ids).includes(:document)
    end

    def self.similarity_scores(query_map)
      scores = {}
      Chunk.find_each do |chunk|
        score = 0
        query_map.each do |word, count|
          score += [count, chunk.vector_sim[word] || 0].min
        end
        scores[chunk.id] = score if score.positive?
      end

      scores
    end
  end
end
