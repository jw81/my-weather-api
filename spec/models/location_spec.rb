# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Location, type: :model do
  describe "'Location' validations" do
    let(:lat) { 39.07 }
    let(:lon) { -93.71 }

    describe "'name' validations" do
      context 'when value is not provided' do
        it 'fails the validation' do
          expect do
            Location.create!(latitude: lat, longitude: lon)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is provided but blank' do
        it 'fails the validation' do
          expect do
            Location.create!(name: '', latitude: lat, longitude: lon)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    describe "'latitude' validations" do
      context 'when value is not provided' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', longitude: lon)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is provided but blank' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', latitude: '', longitude: lon)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is less than -90' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', latitude: -91.00, longitude: lon)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is greater than 90' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', latitude: 91.00, longitude: lon)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    describe "'longitude' validations" do
      context 'when value is not provided' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', latitude: lat)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is provided but blank' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', latitude: lat, longitude: '')
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is less than -180' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', latitude: lat, longitude: -181.00)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is greater than 180' do
        it 'fails the validation' do
          expect do
            Location.create!(name: 'Test', latitude: lat, longitude: 181.00)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
