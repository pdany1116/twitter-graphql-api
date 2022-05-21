# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterGraphqlApiSchema do
  context "with valid tweet" do
    let(:execute_mutation) { described_class.execute(mutation, variables: variables) }
    let(:execute_query) { described_class.execute(query) }
    let(:content) { Faker::Beer.brand }
    let(:mutation) do
      <<~GQL
        mutation($input: CreateTweetInput!) {
          createTweet(input: $input) {
            tweet {
              id
            }
          }
        }
      GQL
    end
    let(:variables) do
      {
        input:
        {
          content: content
        }
      }
    end
    let(:query) do
      <<~GQL
        query {
          tweets {
            id
            content
          }
        }
      GQL
    end

    it "returns the created tweet", :skip => "Tweet Query Type not implemented yet" do
      mutation_result = execute_mutation
      query_result = execute_query

      expect(mutation_result.dig("data", "createTweet", "tweet", "id")).to eq query_result.dig("tweets", "id")
      expect(mutation_result.dig("data", "createTweet", "tweet", "content")).to eq query_result.dig("tweets", "content")
    end
  end
end
