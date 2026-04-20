# frozen_string_literal: true

Rails.application.routes.draw do
  root 'assistant#index'
  post 'upload_document', to: 'assistant#upload_document'
  post 'ask', to: 'assistant#ask'
end
