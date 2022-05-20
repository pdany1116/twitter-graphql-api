# frozen_string_literal: true

module Mutations
  class CreateTweet < Mutations::BaseMutation
    argument :input, Types::CreateTweetInput, required: true

    field :tweet, Types::TweetType

    def resolve(input)
      tweet = Tweet.create(input)

      { tweet: { id: tweet.id } }
    end
  end
end
