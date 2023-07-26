# frozen_string_literal: true

require 'rails_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe Observation, type: :model do
  describe "'Observation' validations" do
    let(:example_temperature) { 75.00 }
    let(:example_description) { 'overcast clouds' }

    describe "'description' validations" do
      context 'when value is not provided' do
        it 'fails the validation' do
          expect do
            Observation.create!(current_temperature: example_temperature)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when value is provided but blank' do
        it 'fails the validation' do
          expect do
            Observation.create!(current_temperature: example_temperature, description: '')
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end

    describe "'current_temperature' validations" do
      context 'when the value is not provided' do
        it 'fails the validation' do
          expect do
            Observation.create!(description: example_description)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when the value is less than -999.99' do
        it 'fails the validation' do
          expect do
            Observation.create!(current_temperature: -1000.00, description: example_description)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end

      context 'when the value is greater than 999.99' do
        it 'fails the validation' do
          expect do
            Observation.create!(current_temperature: 1000.00, description: example_description)
          end.to raise_error(ActiveRecord::RecordInvalid)
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
