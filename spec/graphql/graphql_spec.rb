# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterGraphqlApiSchema do
  context "with valid tweet" do
    let(:execute_mutation) { described_class.execute(mutation, variables: variables) }
    let(:execute_query) { described_class.execute(query) }
    let(:content) { "Here is a link -> https://ogp.me/" }
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
              title
              description
              url
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

      expect(tweets.include?({
                               id: mutation_result.dig("data", "createTweet", "tweet", "id"),
                               content: content,
                               resources: [
                                title: "Open Graph protocol",
                                description: "The Open Graph protocol enables any web page to become a rich object in a social graph.",
                                url: "https://ogp.me/",
                                 image: {
                                   url: "https://ogp.me/logo.png"
                                 }
                               ]
                             })).to eq true
    end
  end
end
