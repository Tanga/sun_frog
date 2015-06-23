require 'rails_helper'

describe Fulfiller::SunFrog::Models::Batch do
  let(:client) { double }
  let(:order)  { double }

  subject { described_class.new(api_client: client) }

  describe '#process' do
    before do
      allow(subject).to receive :add_order
      allow(subject).to receive :finalize
    end

    it 'adds each order to the batch' do
      expect(subject).to receive :add_order
      subject.process(orders: [order])
    end

    it 'finalizes the order' do
      allow(subject).to receive :add_order
      subject.process(orders: [order])
    end
  end

  describe '#add_order' do
    before do
      allow(client).to receive(:start_batch) {
        [{"ResponseAck":"Success","Message":"Batch started.","BatchID":12345,"Status":"Waiting for addOrder","MessageDeveloper":"Waiting for addOrder"}]
      }
    end

    it 'should add the order to the batch' do
      expect(client).to receive(:add_order).with(order: order, batch_id: 12345)
      subject.add_order(order: order)
    end

    it "should only start the batch once" do
      allow(client).to receive(:add_order).with(order: order, batch_id: 12345)
      subject.add_order(order: order)
      allow(client).to receive(:add_order).with(order: order, batch_id: 12345)
      expect(client).to_not receive(:start_batch)
      subject.add_order(order: order)
    end
  end

  describe '#finalize' do
    before do
      # TODO: Figure out how to avoid doing all this setup.
      allow(client).to receive(:start_batch) {
        [{"ResponseAck":"Success","Message":"Batch started.","BatchID":12345,"Status":"Waiting for addOrder","MessageDeveloper":"Waiting for addOrder"}]
      }

      allow(client).to receive(:add_order).with(order: order, batch_id: 12345)

      subject.add_order(order: order)

      allow(client).to receive(:finalize_batch) {
        [{"ResponseAck":"Success","BatchID":12345,"Message":"Batch finalized successfully.","batchTotal":5.00,"MessageDeveloper":"Batch finalized successfully"}]
      }
    end

    it 'should finalize the batch' do
      expect(client).to receive(:end_batch).with(batch_id: 12345, paypal_transaction_id: 'trans_id')
      subject.finalize(paypal_transaction_id: 'trans_id')
    end
  end
end
