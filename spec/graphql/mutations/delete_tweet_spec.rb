# frozen_string_literal: true

require 'rails_helper'
require "./lib/opengraph_metadata"

RSpec.describe TwitterGraphqlApiSchema do
  describe "delete tweet mutation" do
    subject(:execute_mutation) { described_class.execute(mutation, variables: variables) }

    let(:mutation) do
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
    let(:variables) do
      {
        input:
          {
            id: 0
          }
      }
    end

    context "with existing tweet" do
      let(:content) { Faker::Beer.brand }

      before do
        tweet = Tweet.create({ content: content })
        resource = Resource.create(OpenGraphMetadata::Extractor.new("https://ogp.me/").extract)
        tweet.resources << resource
      end

      it "deletes the existing tweet" do
        expect(Tweet.count).to eq 1
        variables[:input][:id] = Tweet.last.id
        execute_mutation
        expect(Tweet.count).to eq 0
      end

      it "does not delete tweet's resources" do
        expect(Resource.count).to eq 1
        variables[:input][:id] = Tweet.last.id
        execute_mutation
        expect(Resource.count).to eq 1
      end
    end

    context "with non-existing tweet" do
      it "returns an error" do
        result = execute_mutation

        expect(result.dig("errors", 0, "message")).to eq "Couldn't find Tweet with 'id'=0"
      end
    end
  end
end
