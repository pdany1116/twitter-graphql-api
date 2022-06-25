require 'nokogiri'
require 'open-uri' # Load content from URL
require 'uri'

module OpenGraphMetadata
  class InvalidURLFormat < StandardError
  end

  class Extractor
    attr_reader :url

    def initialize(url)
      raise InvalidURLFormat, "Invalid format of URL!" if !url.starts_with?("http")

      @url = url
    end
  
    def extract
      doc = Nokogiri::HTML(URI.open(@url))

      {
        title: doc.xpath('//meta[@property="og:title"]').first['content'],
        description: doc.xpath('//meta[@property="og:description"]').first['content'],
        url: doc.xpath('//meta[@property="og:url"]').first['content'],
        image: doc.xpath('//meta[@property="og:image"]').first['content']
      }
    end
  end
end
