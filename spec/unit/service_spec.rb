require 'spec_helper'

describe SunFrog::Service do
  describe '#post' do
    it 'should post orders' do
      batch  = double
      orders = [ApiModels::Order.make, ApiModels::Order.make]
      expect(Fulfiller::SunFrog::Models::Batch).to receive(:new).with(orders: orders) { batch }
      expect(batch).to receive(:process)
      described_class.post(orders: orders)
    end
  end
end
