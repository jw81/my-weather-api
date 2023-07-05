# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Locations', type: :request do
  describe 'GET /locations' do
    context 'with no records in the database' do
      it 'successfully returns an empty collection' do
        get '/locations'
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response).to be_empty
      end
    end

    context 'with records in the database' do
      before do
        @sample_location = Location.create!(name: 'Sample Location', latitude: 39.07, longitude: -93.71)
      end

      it 'successfully returns a populated collection' do
        get '/locations'
        parsed_response = JSON.parse(response.body)
        first_location = parsed_response.first

        expect(response).to have_http_status(:success)
        expect(first_location['name']).to eq(@sample_location.name)
        expect(first_location['latitude']).to eq(@sample_location.latitude.to_s) # find alternative to calling .to_s
        expect(first_location['longitude']).to eq(@sample_location.longitude.to_s) # find alternative to calling .to_s
      end
    end
  end
end
