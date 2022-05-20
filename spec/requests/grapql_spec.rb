require 'rails_helper'

RSpec.describe "GraphQL", type: :request do
  describe "POST /graphql" do
    context "tweets mutations" do
      subject(:post_graphql) { post "/graphql", params: mutation }
      
      context "create tweet" do
        let(:mutation) do
          <<~GQL
            type CreateTweetInput {
              content: String!
            }
            
            mutation($input: CreateTweetInput!) {
              createTweet(input: $input) {
                tweet {
                  id
                }
              }
            }
          GQL
        end
        let(:content) { Faker::Beer.brand }

        it "returns 200" do
          post_graphql
          
          expect(response).to have_http_status(:ok)
        end

        it "creates a tweet", skip: "Not implemented yet" do

        end

        it "returns the created tweet id", skip: "Not implemented yet" do

        end
      end
    end
  end
end