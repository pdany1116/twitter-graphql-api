# frozen_string_literal: true

module Mutations
  class CreateTweet < Mutations::BaseMutation
    argument :content, String

    field :tweet, Types::TweetType

    def resolve(input)
      tweet = Tweet.create(content: input[:content])

      { tweet: }
    end
  end
end
