# frozen_string_literal: true

# CRUD actions for the 'Locations' resource
class LocationsController < ApplicationController
  before_action :load_location, only: [:show, :update, :destroy]

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

  def create
    location = Location.create(location_params)
    render json: location, status: :created
  end

  def update
    if @location
      location = Location.find(params[:id])
      location.update!(location_params)
      render json: location, status: :ok 
    else
      message = "No location found with id: #{params[:id]}"
      render  json: { error: message }, status: :not_found      
    end
  end

  def destroy
    if @location
      location = Location.destroy(params[:id])
      render json: location, status: :ok 
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
