require "./lib/opengraph_metadata"
require "rails_helper"

RSpec.describe OpenGraphMetadata::Extractor do
  describe ".extract" do
    subject(:extract) { described_class.new(url).extract }

    context "with valid url" do
      let(:url) { "https://ogp.me/" }

      it "returns a hash with valid title, description, url and image_url" do
        result = extract

        expect(result).to eq({
                               title: "Open Graph protocol",
                               description: "The Open Graph protocol enables any web page to become a rich object in a social graph.",
                               url: "https://ogp.me/",
                               image: "https://ogp.me/logo.png"
                             })
      end
    end

    context "with invalid url" do
      context "with empty url" do
        let(:url) { "" }

        it "raises invalid format url" do
          expect { extract }.to raise_error(OpenGraphMetadata::InvalidURLFormat, "Invalid format of URL!")
        end
      end

      context "with incorrect format of url (wrong protocol)" do
        let(:url) { "ht://12ft.io/" }

        it "raises invalid format url" do
          expect { extract }.to raise_error(OpenGraphMetadata::InvalidURLFormat, "Invalid format of URL!")
        end
      end
    end
  end
end
