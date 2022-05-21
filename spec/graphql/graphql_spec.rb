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
            resources {
              image {
                url
              }
            }
          }
        }
      GQL
    end

    it "returns the created tweet" do
      mutation_result = execute_mutation
      query_result = execute_query

      tweets = JSON.parse(query_result["data"]["tweets"].to_json, symbolize_names: true)
      pp tweets
      expect(tweets.include?({
                               id: mutation_result.dig("data", "createTweet", "tweet", "id"),
                               content: content,
                               resources: [
                                 image: {
                                   url: "https://placekitten.com/200/300"
                                 }
                               ]
                             })).to eq true
    end
  end
end
