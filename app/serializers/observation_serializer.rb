# frozen_string_literal: true

# JSON serializer for the 'Observation' model
class ObservationSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :description, :current_temperature, :created_at
  belongs_to :location
end
