# frozen_string_literal: true

class AssistantController < ApplicationController
  def index
    @documents = Document.order(created_at: :desc)
    @question = Question.new
    @previous_questions = Question.order(created_at: :desc).limit(5)
  end

  def upload_document
    file = params.dig(:document, :file)

    unless valid_file?(file)
      return redirect_to root_path, alert: 'Invalid file! Please upload a .txt, .pdf, or .docx file.'
    end

    @document = Document.new(document_params)
    if @document.save
      Knowledge::Processor.call(@document, file)
      redirect_to root_path, notice: 'Knowledge base updated successfully!'
    else
      redirect_to root_path, alert: @document.errors.full_messages.to_sentence
    end
  end

  def ask
    query = params.dig(:question, :user_query)

    return @error = 'Please upload a document first!' if Document.none?

    @relevant_chunks = Knowledge::Searcher.call(query)

    if @relevant_chunks.any?
      @question = Question.create(
        user_query: query,
        ai_response: Knowledge::Synthesizer.generate_answer(@relevant_chunks),
        metadata: { source_document_names: @relevant_chunks.map { |c| c.document.name }.uniq }
      )
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to root_path }
    end
  end

  private

  def document_params
    params.require(:document).permit(:name)
  end

  def valid_file?(file)
    return false unless file.respond_to?(:content_type)

    %w[
      text/plain
      application/pdf
      application/vnd.openxmlformats-officedocument.wordprocessingml.document
    ].include?(file.content_type)
  end
end
