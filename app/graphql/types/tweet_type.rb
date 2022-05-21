# frozen_string_literal: true

module Types
  class TweetType < Types::BaseObject
    field :id, Int, null: false
    field :content, String, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :resources, [Types::ResourceType], null: false
  end
end
