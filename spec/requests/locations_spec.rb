# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Locations', type: :request do
  describe 'GET /locations' do
    context 'with no records in the database' do
      it 'successfully returns an empty collection' do
        get '/locations'
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response['data']).to be_empty
      end
    end

    context 'with records in the database' do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
      end

      it 'successfully returns a populated collection' do
        get '/locations'
        parsed_response = JSON.parse(response.body)
        first_location = parsed_response['data'].first

        expect(response).to have_http_status(:success)
        expect(first_location['attributes']['name']).to eq(@test_location['name'])
        expect(first_location['attributes']['latitude']).to eq(@test_location['latitude'])
        expect(first_location['attributes']['longitude']).to eq(@test_location['longitude'])
      end
    end
  end

  describe 'GET /locations/:id' do
    context "when 'location' does not exist" do
      it 'returns HTTP status 404' do
        get '/locations/1'

        expect(response.status).to eq(404)
      end
    end

    context "when 'location' does exist" do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
      end

      it "successfully returns the 'location'" do
        get "/locations/#{@test_location.id}"
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response['data']['attributes']['name']).to eq(@test_location['name'])
        expect(parsed_response['data']['attributes']['latitude']).to eq(@test_location['latitude'])
        expect(parsed_response['data']['attributes']['longitude']).to eq(@test_location['longitude'])
      end
    end
  end

  describe 'POST /locations' do
    it "successfully creates a new 'location'" do
      post '/locations',
           params: {
             location: {
               name: 'Washington D.C.',
               latitude: '38.8951',
               longitude: '-77.0364'
             }
           }

      expect(response.status).to eq(201)
    end
  end

  describe 'PUT /locations/:id' do
    context "when 'location' does not exist" do
      it 'returns HTTP status 404' do
        put '/locations/1',
            params: {
              location: {
                name: 'Washington D.C. USA',
                latitude: '38.8951',
                longitude: '-77.0364'
              }
            }

        expect(response.status).to eq(404)
      end
    end

    context "when 'location' does exist" do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
      end

      it "successfully updates the 'location'" do
        put "/locations/#{@test_location.id}",
            params: {
              location: {
                name: 'Washington D.C. USA',
                latitude: '38.8951',
                longitude: '-77.0364'
              }
            }
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response['data']['attributes']['name']).to eq('Washington D.C. USA')
        expect(parsed_response['data']['attributes']['latitude']).to eq(@test_location['latitude'])
        expect(parsed_response['data']['attributes']['longitude']).to eq(@test_location['longitude'])
      end
    end
  end

  describe 'DELETE /locations/:id' do
    context "when 'location' does not exist" do
      it 'returns HTTP status 404' do
        delete '/locations/1'

        expect(response.status).to eq(404)
      end
    end

    context "when 'location' does exist" do
      before do
        @test_location = Location.create!(name: 'Sample Location', latitude: '38.8951', longitude: '-77.0364')
      end

      it "successfully deletes the 'location'" do
        delete "/locations/#{@test_location.id}"
        parsed_response = JSON.parse(response.body)

        expect(response).to have_http_status(:success)
        expect(parsed_response['data']['attributes']['name']).to eq(@test_location['name'])
        expect(parsed_response['data']['attributes']['latitude']).to eq(@test_location['latitude'])
        expect(parsed_response['data']['attributes']['longitude']).to eq(@test_location['longitude'])
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
