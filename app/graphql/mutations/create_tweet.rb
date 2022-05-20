# frozen_string_literal: true

class Mutations::CreateTweet < Mutations::BaseMutation
  argument :input, Types::CreateTweetInput, required: true

  field :tweet, Types::TweetType

  def resolve(input)
    tweet = Tweet.create(input)

    { tweet: { id: tweet.id } }
  end
end
