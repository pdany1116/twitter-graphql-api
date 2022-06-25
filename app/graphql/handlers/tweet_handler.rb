# frozen_string_literal: true

require 'uri'
require "./lib/opengraph_metadata"

module Handlers
  class TweetHandler
    def self.handle(content)
      tweet = Tweet.create(content: content)
      urls = URI.extract(content).uniq

      urls.map do |url|
        begin
          resource = Resource.create(OpenGraphMetadata::Extractor.new(url).extract)
          tweet.resources << resource
        rescue OpenGraphMetadata::InvalidURLFormat
          # Ignored
        end
      end

      tweet
    end
  end
end
