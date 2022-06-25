# frozen_string_literal: true

module Mutations
  class CreateTweet < Mutations::BaseMutation
    argument :content, String

    field :tweet, Types::TweetType

    def resolve(input)
      { tweet: Handlers::TweetHandler.handle(input[:content]) }
    end
  end
end
