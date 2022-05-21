# frozen_string_literal: true

module Types
  class TweetType < Types::BaseObject
    field :id, Int, null: false
    field :content, String, null: false
    field :resources, [Types::ResourceType], null: false

    def resources
      dataloader.with(::Sources::ResourceObject).load(object.id)
    end
  end
end
