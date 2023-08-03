# frozen_string_literal: true

# Represents a location on Earth
class Location < ApplicationRecord
  has_many :observations
  validates :name, presence: true

  validates :latitude, presence: true
  validates :latitude, numericality: { greater_than_or_equal_to: -90, less_than_or_equal_to: 90 }

  validates :longitude, presence: true
  validates :longitude, numericality: { greater_than_or_equal_to: -180, less_than_or_equal_to: 180 }
end
