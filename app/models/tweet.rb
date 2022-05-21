# frozen_string_literal: true

class Tweet < ApplicationRecord
  has_many :resources, dependent: :destroy
end
