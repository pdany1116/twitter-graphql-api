module Handlers
  class TweetHandler
    def self.handle(content)
      Tweet.create(content: content)
    end
  end
end
