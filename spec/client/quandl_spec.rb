require './spec/spec_helper.rb'

RSpec.describe Client::Quandl do

  describe 'get stock data' do
    let(:stock_name) { 'AAPL' }

    subject do
      described_class.new
    end

    context 'metadata by name' do
      around(:each) { |example| VCR.use_cassette('/quandl/metadata') { example.run } }

      it 'will return hash data' do
        expect(subject.metadata_by_name(stock_name)).to be_a(Hash)
      end
    end

    context 'specific data with start and end date' do
      let(:start_date) { 'Jan 1 2018' }
      let(:end_date) { 'Jan 5 2018' }
      let(:options) do
        {
          described_class::START_DATE => start_date,
          described_class::END_DATE => end_date
        }
      end

      around(:each) { |example| VCR.use_cassette('/quandl/specific_data_option') { example.run } }

      it 'will return hash data' do
        expect(subject.stock_by_name(stock_name, options)).to be_a(Hash)
      end
      it 'will have dataset_data field as hash' do
        expect(subject.stock_by_name(stock_name, options)['dataset_data']).to be_a(Hash)
      end
    end

    context 'filtered data with start and end date' do
      let(:start_date) { 'Jan 1 2018' }
      let(:end_date) { 'Jan 5 2018' }

      around(:each) { |example| VCR.use_cassette('/quandl/filtered_data') { example.run } }

      it 'will return hash data' do
        expect(subject.filter_by_date(stock_name, start_date, end_date)).to be_a(Hash)
      end

      it 'will have dataset field as hash' do
        expect(subject.filter_by_date(stock_name, start_date, end_date)['dataset']).to be_a(Hash)
      end

      it 'will have dataset code same as requested' do
        expect(subject.filter_by_date(stock_name, start_date, end_date)['dataset']['dataset_code']).to eq(stock_name)
      end
    end
  end
end
