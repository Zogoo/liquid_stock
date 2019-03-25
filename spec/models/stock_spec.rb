require './spec/spec_helper.rb'

RSpec.describe Models::Stock do
  describe 'load_from_dataset' do
    let(:data_set) do
      File.open('spec/data/sample_response.json') do |j|
        JSON.load(j)
      end
    end

    subject do
      described_class.load_from_dataset(data_set)
    end

    it 'will return array' do
      is_expected.to be_a(Array)
    end

    it 'all item of array will be stock object' do
      is_expected.to satisfy do |array_obj|
        array_obj.all? { |obj| obj.is_a?(described_class) }
      end
    end

    it 'all stock object respond to date' do
      is_expected.to satisfy do |array_obj|
        array_obj.all? { |obj| obj.respond_to?(:date) }
      end
    end

    it 'all stock object respond to open' do
      is_expected.to satisfy do |array_obj|
        array_obj.all? { |obj| obj.respond_to?(:open) }
      end
    end

    it 'all stock object respond to high' do
      is_expected.to satisfy do |array_obj|
        array_obj.all? { |obj| obj.respond_to?(:high) }
      end
    end

    it 'all stock object respond to low' do
      is_expected.to satisfy do |array_obj|
        array_obj.all? { |obj| obj.respond_to?(:low) }
      end
    end

    it 'all stock object respond to close' do
      is_expected.to satisfy do |array_obj|
        array_obj.all? { |obj| obj.respond_to?(:close) }
      end
    end
  end
end
