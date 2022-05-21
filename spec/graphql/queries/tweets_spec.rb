# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterGraphqlApiSchema do
  describe "tweets query" do
    subject(:execute_query) { described_class.execute(query) }

    context "with existing tweets" do
      let(:content) { Faker::Beer.brand }
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

      it "returns the created tweet with correct id and content" do
        # TODO: add factory bot
        tweet = Tweet.create(content: content)
        resource = Resource.create(image: "https://placekitten.com/200/300")
        tweet.resources << resource

        query_result = execute_query

        tweets = JSON.parse(query_result["data"]["tweets"].to_json, symbolize_names: true)
        expect(tweets.include?({
                                 id: tweet.id,
                                 content: tweet.content,
                                 resources: [
                                   image: { url: "https://placekitten.com/200/300" }
                                 ]
                               })).to eq true
      end
    end
  end
end