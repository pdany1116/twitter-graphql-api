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

    it "returns the created tweet" do
      mutation_result = execute_mutation
      query_result = execute_query

      expect(query_result.dig("data", "tweets", 0, "id")).to eq mutation_result.dig("data", "createTweet", "tweet", "id")
      expect(query_result.dig("data", "tweets", 0, "content")).to eq content
    end
  end
end
