# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Observations', type: :request do
  let(:example_temperature) { 75.00 }
  let(:example_description) { 'overcast clouds' }

  describe 'GET /locations/:location_id/observations' do
    context 'with no records in the database' do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
      end

      it 'successfully returns an empty collection' do
        get "/locations/#{@test_location.id}/observations"
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response).to be_empty
      end
    end

    context 'with records in the database' do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
        @test_location.observations.create!(
          current_temperature: example_temperature,
          description: example_description
        )
      end

      it 'successfully returns a populated collection' do
        get "/locations/#{@test_location.id}/observations"
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response.count).to eq(1)
      end
    end
  end

  describe 'GET /locations/:location_id/observations/:observation_id' do
    context "when the 'observation' does not exist" do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
      end

      it 'returns HTTP status 404' do
        get "/locations/#{@test_location.id}/observations/999999"

        expect(response.status).to eq(404)
      end
    end

    context "when the 'observation' does exist" do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
        @test_observation = @test_location.observations.create!(
          current_temperature: example_temperature,
          description: example_description
        )
      end

      it "successfully returns the 'observation'" do
        get "/locations/#{@test_location.id}/observations/#{@test_observation.id}"
        JSON.parse(response.body)

        expect(response).to have_http_status(:success)
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
