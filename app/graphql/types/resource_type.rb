# frozen_string_literal: true

module Types
  class ResourceType < Types::BaseObject
    field :id, ID
    field :image, Types::ImageType

    def image
      OpenStruct.new(url: self.object.image)
    end

    # field :title, String, null: false
    # field :description, String, null: false
    # field :url, String, null: false
  end
end
