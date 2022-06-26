# frozen_string_literal: true

require 'uri'
require "./lib/opengraph_metadata"

module Handlers
  class CreateTweetHandler
    def self.handle(content)
      tweet = Tweet.create(content: content)
      urls = URI.extract(content).uniq

      urls.map do |url|
        resource = Resource.create(OpenGraphMetadata::Extractor.new(url).extract)
        tweet.resources << resource
      rescue OpenGraphMetadata::InvalidURLFormat
        # Ignored
      end

      tweet
    end
  end
end
