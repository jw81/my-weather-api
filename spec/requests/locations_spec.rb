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
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
      end

      it 'successfully returns a populated collection' do
        get '/locations'
        parsed_response = JSON.parse(response.body)
        first_location = parsed_response.first

        expect(response).to have_http_status(:success)
        expect(first_location['name']).to eq(@test_location['name'])
        expect(first_location['latitude']).to eq(@test_location['latitude'])
        expect(first_location['longitude']).to eq(@test_location['longitude'])
      end
    end
  end
end
