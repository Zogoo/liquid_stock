require './spec/spec_helper.rb'

RSpec.describe Calculate::DrawDown do
  describe 'max draw down value by peak value and lowset value' do
    subject do
      described_class.max_drawdown(peak_val, lowest_val)
    end

    context 'when give portfolios result with (172.3 - 169.26) / 172.3 = -1.8' do
      let(:peak_val) { 172.3 }
      let(:lowest_val) { 169.26 }

      it 'will return percentage value' do
        is_expected.to eq(-1.8)
      end
    end

    context 'when give portfolios result with (174.55 - 171.96) / 171.96 = -1.5' do
      let(:peak_val) { 174.55 }
      let(:lowest_val) { 171.96 }

      it 'will return percentage value' do
        is_expected.to eq(-1.5)
      end
    end

    context 'when give portfolios result with (175.37 - 173.05) / 173.05 = -1.3' do
      let(:peak_val) { 175.37 }
      let(:lowest_val) { 173.05 }

      it 'will return percentage value' do
        is_expected.to eq(-1.3)
      end
    end
  end

  describe 'max drawdown value by given portfolios' do
    let(:portfolios) { nil }

    subject do
      described_class.max_drawdown_by_portfolios(portfolios)
    end

    context 'when variable is other than array' do
      let(:portfolios) { '[{"2018-01-02" => 123.2}, {"2018-01-02" => 341,2}, {"2018-01-02" => 333,2}]' }

      it 'will raise invalid input error' do
        expect { subject }.to raise_error(Common::Error::WrongInput)
      end
    end

    context 'when portfolios for max drawdown result with (172.3 - 169.26) / 172.3 = -1.8' do
      let(:portfolios) do
        [
          { '2018-01-02' => 172.3 }, { '2018-01-02' => 169.26 },
          { '2018-01-03' => 174.55 }, { '2018-01-03' => 171.96 },
          { '2018-01-04' => 173.47 }, { '2018-01-04' => 172.08 },
          { '2018-01-05' => 175.37 }, { '2018-01-05' => 173.05 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(-1.8)
      end
    end

    context 'when portfolios for max drawdown result with (172.3 - 169.26) / 172.3 = -1.8' do
      let(:portfolios) do
        [
          { '2018-01-02' => 170.16 }, { '2018-01-02' => 172.3 }, { '2018-01-02' => 169.26 }, { '2018-01-02' => 172.26 },
          { '2018-01-03' => 172.53 }, { '2018-01-03' => 174.55 }, { '2018-01-03' => 171.96 }, { '2018-01-03' => 172.23 },
          { '2018-01-04' => 172.54 }, { '2018-01-04' => 173.47 }, { '2018-01-04' => 172.08 }, { '2018-01-04' => 173.03 },
          { '2018-01-05' => 173.44 }, { '2018-01-05' => 175.37 }, { '2018-01-05' => 173.05 }, { '2018-01-05' => 175.0 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(-1.8)
      end
    end

    context 'when portfolios for max drawdown result with (172.53 - 172.23) / 172.53 = -0.2' do
      let(:portfolios) do
        [
          { '2018-01-02' => 170.16 }, { '2018-01-02' => 172.26 },
          { '2018-01-03' => 172.53 }, { '2018-01-03' => 172.23 },
          { '2018-01-04' => 172.54 }, { '2018-01-04' => 173.03 },
          { '2018-01-05' => 173.44 }, { '2018-01-05' => 175.0 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(-0.2)
      end
    end

    context 'when portfolios for max drawdown result with (150,000-80,000)/150,000 = -46.7' do
      let(:portfolios) do
        [
          { '2009-11-05' => 100 },
          { '2009-11-06' => 150 },
          { '2009-11-07' => 90 },
          { '2009-11-08' => 120 },
          { '2009-11-09' => 80 },
          { '2009-11-10' => 200 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(-46.7)
      end
    end

    context 'when portfolios for max drawdown result with (200-80)/200 = -60.0' do
      let(:portfolios) do
        [
          { '2018-01-05' => 100 },
          { '2018-01-05' => 150 },
          { '2018-01-05' => 90 },
          { '2018-01-05' => 120 },
          { '2018-01-05' => 200 },
          { '2018-01-05' => 80 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(-60.0)
      end
    end

    context 'when portfolios for max drawdown result with (150,000-90,000)/150,000 = -40.0' do
      let(:portfolios) do
        [
          { '2018-01-05' => 100 },
          { '2018-01-05' => 150 },
          { '2018-01-05' => 90 },
          { '2018-01-05' => 120 },
          { '2018-01-05' => 200 },
          { '2018-01-05' => 200 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(-40.0)
      end
    end

    context 'when portfolios for max drawdown result with 0' do
      let(:portfolios) do
        [
          { '2018-01-05' => 100 },
          { '2018-01-05' => 100 },
          { '2018-01-05' => 100 },
          { '2018-01-05' => 100 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(0.0)
      end
    end

    context 'when portfolios for max drawdown result with 0' do
      let(:portfolios) do
        [
          { '2018-01-05' => 100 },
          { '2018-01-05' => 100 },
          { '2018-01-05' => 150 },
          { '2018-01-05' => 150 }
        ]
      end

      it 'will return value as same as contect explanation' do
        is_expected.to eq(0.0)
      end
    end
  end

  describe 'drawdown hash from given portfolios' do
    subject do
      described_class.draw_down_hash(portfolios)
    end

    context 'when variable is other than array' do
      let(:portfolios) { '[{"2018-01-02" => 123.2}, {"2018-01-02" => 341,2}, {"2018-01-02" => 333,2}]' }

      it 'will raise invalid input error' do
        expect { subject }.to raise_error(Common::Error::WrongInput)
      end
    end

    context 'when array of portfolios with 3 drawdown' do
      let(:portfolios) do
        [
          { '2018-01-02' => 172.3 }, { '2018-01-02' => 169.26 },
          { '2018-01-03' => 174.55 }, { '2018-01-03' => 171.96 },
          { '2018-01-04' => 173.47 }, { '2018-01-04' => 172.08 },
          { '2018-01-05' => 175.37 }, { '2018-01-05' => 173.05 }
        ]
      end

      it 'will return array of drawdown hash' do
        is_expected.to be_a(Array)
      end

      it 'will return one array of draw down' do
        expect(subject.compact.size).to eq(3)
      end

      it 'will return hash values with drawdown' do
        is_expected.to satisfy do |value|
          value.compact.all? { |d_hash| !d_hash[:loss].nil? }
        end
      end
    end

    context 'when array of portfolios with 3 drawdown' do
      let(:portfolios) do
        [
          { '2018-01-02' => 170.16 }, { '2018-01-02' => 172.3 }, { '2018-01-02' => 169.26 }, { '2018-01-02' => 172.26 },
          { '2018-01-03' => 172.53 }, { '2018-01-03' => 174.55 }, { '2018-01-03' => 171.96 }, { '2018-01-03' => 172.23 },
          { '2018-01-04' => 172.54 }, { '2018-01-04' => 173.47 }, { '2018-01-04' => 172.08 }, { '2018-01-04' => 173.03 },
          { '2018-01-05' => 173.44 }, { '2018-01-05' => 175.37 }, { '2018-01-05' => 173.05 }, { '2018-01-05' => 175.0 }
        ]
      end

      it 'will return array of drawdown hash' do
        is_expected.to be_a(Array)
      end

      it 'will return one array of draw down' do
        expect(subject.compact.size).to eq(3)
      end

      it 'will return hash values with drawdown' do
        is_expected.to satisfy do |value|
          value.compact.all? { |d_hash| !d_hash[:loss].nil? }
        end
      end
    end

    # When pick up drawdown from open and close value
    context 'when array of portfolios with 1 drawdown' do
      let(:portfolios) do
        [
          { '2018-01-02' => 170.16 }, { '2018-01-02' => 172.26 },
          { '2018-01-03' => 172.53 }, { '2018-01-03' => 172.23 },
          { '2018-01-04' => 172.54 }, { '2018-01-04' => 173.03 },
          { '2018-01-05' => 173.44 }, { '2018-01-05' => 175.0 }
        ]
      end

      it 'will return array of drawdown hash' do
        is_expected.to be_a(Array)
      end

      it 'will return one array of draw down' do
        expect(subject.compact.size).to eq(1)
      end

      it 'will return hash values with drawdown' do
        is_expected.to satisfy do |value|
          value.compact.all? { |d_hash| !d_hash[:loss].nil? }
        end
      end
    end

    context 'when array of portfolios with 2 drawdown' do
      let(:portfolios) do
        [
          { '2009-11-05' => 100 },
          { '2009-11-06' => 150 },
          { '2009-11-07' => 90 },
          { '2009-11-08' => 120 },
          { '2009-11-09' => 80 },
          { '2009-11-10' => 200 }
        ]
      end

      it 'will return array of drawdown hash' do
        is_expected.to be_a(Array)
      end

      it 'will return one array of draw down' do
        expect(subject.compact.size).to eq(2)
      end

      it 'will return hash values with drawdown' do
        is_expected.to satisfy do |value|
          value.compact.all? { |d_hash| !d_hash[:loss].nil? }
        end
      end
    end

    context 'when array of portfolios with 5 drawdown' do
      let(:portfolios) do
        [
          { '2018-01-05' => 100 },
          { '2018-01-05' => 150 },
          { '2018-01-05' => 90 },
          { '2018-01-05' => 120 },
          { '2018-01-05' => 160 },
          { '2018-01-05' => 150 },
          { '2018-01-05' => 125 },
          { '2018-01-05' => 100 },
          { '2018-01-05' => 75 }
        ]
      end

      it 'will return array of drawdown hash' do
        is_expected.to be_a(Array)
      end

      it 'will return one array of draw down' do
        expect(subject.compact.size).to eq(5)
      end

      it 'will return hash values with drawdown' do
        is_expected.to satisfy do |value|
          value.compact.all? { |d_hash| !d_hash[:loss].nil? }
        end
      end
    end

    context 'when array of portfolios with 0 drawdown' do
      let(:portfolios) do
        [
          { '2018-01-05' => 100 },
          { '2018-01-05' => 100 },
          { '2018-01-05' => 100 },
          { '2018-01-05' => 100 }
        ]
      end

      it 'will return array of drawdown hash' do
        is_expected.to be_a(Array)
      end

      it 'will return one array of draw down' do
        expect(subject.compact.size).to eq(0)
      end

      it 'will return hash values with drawdown' do
        is_expected.to satisfy do |value|
          value.compact.all? { |d_hash| !d_hash[:loss].nil? }
        end
      end
    end
  end
end
