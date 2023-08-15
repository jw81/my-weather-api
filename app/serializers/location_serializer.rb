# frozen_string_literal: true

# JSON serializer for the 'Location' model
class LocationSerializer
  include FastJsonapi::ObjectSerializer
  set_key_transform :camel_lower
  attributes :latitude, :longitude, :name
end
