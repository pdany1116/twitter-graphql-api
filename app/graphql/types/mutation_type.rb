module Types
  class MutationType < Types::BaseObject
    field :create_tweet, mutation: Mutations::CreateTweet
  end
end
