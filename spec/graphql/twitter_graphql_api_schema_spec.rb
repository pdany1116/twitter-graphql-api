# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterGraphqlApiSchema do
  context "with valid tweet" do
    let(:execute_create_tweet_mutation) { described_class.execute(create_tweet_mutation, variables: create_tweet_variables) }
    let(:execute_delete_tweet_mutation) { described_class.execute(delete_tweet_mutation, variables: delete_tweet_variables) }
    let(:execute_query) { described_class.execute(query) }
    let(:content) { "Here is a link -> https://ogp.me/" }
    let(:create_tweet_mutation) do
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
    let(:create_tweet_variables) do
      {
        input:
        {
          content: content
        }
      }
    end
    let(:delete_tweet_mutation) do
      <<~GQL
        mutation($input: DeleteTweetInput!) {
          deleteTweet(input: $input) {
            tweet {
              id
            }
          }
        }
      GQL
    end
    let(:delete_tweet_variables) do
      {
        input:
          {
            id: 0
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
      mutation_result = execute_create_tweet_mutation
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
                             })).to be true
    end

    it "deletes the created tweet" do
      mutation_result = execute_create_tweet_mutation
      query_result = execute_query

      tweets = JSON.parse(query_result["data"]["tweets"].to_json, symbolize_names: true)
      tweet_id = mutation_result.dig("data", "createTweet", "tweet", "id")

      expect(tweets.include?({
                               id: tweet_id,
                               content: content,
                               resources: [
                                 title: "Open Graph protocol",
                                 description: "The Open Graph protocol enables any web page to become a rich object in a social graph.",
                                 url: "https://ogp.me/",
                                 image: {
                                   url: "https://ogp.me/logo.png"
                                 }
                               ]
                             })).to be true

      delete_tweet_variables[:input][:id] = tweet_id
      execute_delete_tweet_mutation
      query_result = execute_query

      tweets = JSON.parse(query_result["data"]["tweets"].to_json, symbolize_names: true)

      expect(tweets.include?({ id: tweet_id })).to be false
    end
  end
end
