# frozen_string_literal: true

class CreateTweetResource < ActiveRecord::Migration[7.0]
  def change
    create_table :resources_tweets, id: false do |t|
      t.belongs_to :tweet
      t.belongs_to :resource
    end
  end
end
