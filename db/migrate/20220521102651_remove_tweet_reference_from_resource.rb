# frozen_string_literal: true

class RemoveTweetReferenceFromResource < ActiveRecord::Migration[7.0]
  def change
    change_table :resources do |t|
      t.remove :tweet_id, type: :int
    end
  end
end
