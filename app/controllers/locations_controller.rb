# frozen_string_literal: true

# CRUD actions for the 'Locations' resource
class LocationsController < ApplicationController
  before_action :load_location, only: :show

  def index
    locations = Location.all

    render json: locations
  end

  def show
    if @location
      render json: @location
    else
      message = "No location found with id: #{params[:id]}"
      render  json: { error: message }, status: :not_found
    end
  end

  private

  def load_location
    @location = Location.find_by_id(params[:id])
  end
end
