# frozen_string_literal: true

# CRUD actions for the 'Observations' resource
class ObservationsController < ApplicationController
  before_action :load_location, only: %i[index show]
  before_action :load_observation, only: %i[show]

  def index
    observations = @location.observations
    render json: ObservationSerializer.new(observations).serialized_json
  end

  def show
    if @observation
      render json: ObservationSerializer.new(@observation).serialized_json
    else
      message = "No observation found with id: #{params[:observation_id]}"
      render  json: { error: message }, status: :not_found
    end
  end

  private

  def load_location
    @location = Location.find_by_id(params[:location_id])
  end

  def load_observation
    @observation = @location.observations.find_by_id(params[:id])
  end
end
