# frozen_string_literal: true

class Resource < ApplicationRecord
  has_and_belongs_to_many :tweets
end
