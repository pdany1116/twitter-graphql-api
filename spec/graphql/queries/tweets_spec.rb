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

        result = execute_query

        expect(result.dig("data", "tweets", 0, "id")).to eq tweet.id
        expect(result.dig("data", "tweets", 0, "content")).to eq tweet.content
      end
    end
  end
end