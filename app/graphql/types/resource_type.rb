# frozen_string_literal: true

module Types
  class ResourceType < Types::BaseObject
    field :id, ID
    field :image, Types::ImageType
    field :title, String, null: false
    field :description, String, null: false
    field :url, String, null: false

    def image
      OpenStruct.new(url: object.image)
    end
  end
end
