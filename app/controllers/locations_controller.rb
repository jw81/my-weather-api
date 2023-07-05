# frozen_string_literal: true

# CRUD actions for the 'Locations' resource
class LocationsController < ApplicationController
  def index
    locations = Location.all

    render json: locations
  end
end
