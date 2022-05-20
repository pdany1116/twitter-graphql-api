# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_tweet, mutation: Mutations::CreateTweet
  end
end
