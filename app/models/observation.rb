# frozen_string_literal: true

# Represents a weather observation
class Observation < ApplicationRecord
  validates :description, presence: true

  validates :current_temperature, presence: true
  validates :current_temperature, numericality: { greater_than_or_equal_to: -999.99, less_than_or_equal_to: 999.99 }
end
