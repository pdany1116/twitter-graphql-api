# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterGraphqlApiSchema do
  describe "create tweet mutation" do
    subject(:execute_mutation) { described_class.execute(mutation, variables: variables) }

    context "with create tweet" do
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

      it "creates a tweet" do
        expect { execute_mutation }.to change(Tweet, :count).by(1)
      end

      it "returns the created tweet id" do
        result = execute_mutation

        expect(result.dig("data", "createTweet", "tweet", "id")).to eq Tweet.last.id
      end
    end
  end
end
