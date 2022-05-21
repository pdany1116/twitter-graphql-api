module Handlers
  class TweetHandler
    def self.handle(content)
      tweet = Tweet.create(content:)

      10.times do
        resource = Resource.create(image: "https://placekitten.com/200/300")
        tweet.resources << resource
      end

      tweet
    end
  end
end
