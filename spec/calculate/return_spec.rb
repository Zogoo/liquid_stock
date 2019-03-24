require 'spec_helper'

RSpec.describe Calculate::Return do

  describe 'return rate' do
    let(:closed_portfolios) { [172.26, 172.23, 173.03, 175.0] }
    let(:initial_value) { closed_portfolios.first }
    let(:final_value) { closed_portfolios.last }
    subject do
      described_class.rate(final_value, initial_value)
    end

    context 'when give final and initial value for (175.0 - 172.26) / 172.26' do
      it 'will return return correct value as 1.6' do
        is_expected.to eq(1.6)
      end
    end
  end
end
