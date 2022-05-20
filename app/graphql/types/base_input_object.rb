module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument
  end

  class CreateTweetInput < BaseInputObject
    argument :content, String, required: true
  end
end
