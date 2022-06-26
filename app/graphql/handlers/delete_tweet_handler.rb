# frozen_string_literal: true

module Handlers
  class DeleteTweetHandler
    def self.handle(id)
      Tweet.find(id).destroy
    rescue ActiveRecord::RecordNotFound => e
      GraphQL::ExecutionError.new(e.message)
    end
  end
end
