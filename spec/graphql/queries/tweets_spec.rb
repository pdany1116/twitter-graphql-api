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
          }
        }
        GQL
      end

      it "returns the created tweet with correct id and content" do
        tweet = Tweet.create(content: content)

        query_result = execute_query

        tweets = JSON.parse(query_result["data"]["tweets"].to_json, symbolize_names: true)
        expect(tweets.include?({
                                id: tweet.id,
                                content: tweet.content
                              })).to eq true
      end
    end
  end
end