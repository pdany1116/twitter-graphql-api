# frozen_string_literal: true

module Mutations
  class DeleteTweet < Mutations::BaseMutation
    argument :id, Int

    field :tweet, Types::TweetType

    def resolve(input)
      { tweet: Handlers::DeleteTweetHandler.handle(input[:id]) }
    end
  end
end
