# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mutations::CreateTweet do
  subject(:create_tweet) { described_class.new(object: nil, context: nil, field: nil) }

  describe ".resolve" do
    context "with valid tweet" do
      let(:create_tweet_input) do
        {
          content: content
        }
      end
      let(:content) { Faker::Beer.brand }

      it "creates a tweet" do
        expect { create_tweet.resolve(create_tweet_input) }.to change(Tweet, :count).by(1)
      end

      it "returns the created tweet id" do
        response = create_tweet.resolve(create_tweet_input)

        expect(response).to eq({ tweet: { id: Tweet.last.id } })
      end
    end
  end
end
