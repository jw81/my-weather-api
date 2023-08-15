# frozen_string_literal: true

# CRUD actions for the 'Locations' resource
class LocationsController < ApplicationController
  before_action :load_location, only: %i[show update destroy]

  def index
    locations = Location.all
    render json: LocationSerializer.new(locations).serialized_json
  end

  def show
    if @location
      render json: LocationSerializer.new(@location).serialized_json
    else
      message = "No location found with id: #{params[:id]}"
      render  json: { error: message }, status: :not_found
    end
  end

  def create
    location = Location.create(location_params)
    render json: LocationSerializer.new(location).serialized_json, status: :created
  end

  def update
    if @location
      @location.update!(location_params)
      render json: LocationSerializer.new(@location).serialized_json, status: :ok
    else
      message = "No location found with id: #{params[:id]}"
      render  json: { error: message }, status: :not_found
    end
  end

  def destroy
    if @location
      @location.destroy!
      render json: LocationSerializer.new(@location).serialized_json, status: :ok
    else
      message = "No location found with id: #{params[:id]}"
      render  json: { error: message }, status: :not_found
    end
  end

  private

  def load_location
    @location = Location.find_by_id(params[:id])
  end

  def location_params
    params.require(:location).permit(:name, :latitude, :longitude)
  end
end
