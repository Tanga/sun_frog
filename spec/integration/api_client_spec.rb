require 'rails_helper'

describe Fulfiller::SunFrog::ApiClient do

  # This is the id sun frog assigned to our batch when the cassette was recorded
  def batch_id
    92
  end

  describe '#start_batch' do
    it 'should start the batch' do
      VCR.use_cassette('sun_frog_start_batch') do
        described_class.start_batch
      end
    end
  end

  describe '#add_order' do
    it 'should add an order to the batch' do
      sun_frog_order = Fulfiller::SunFrog::Models::Order.new(ApiModels::Order.make)

      VCR.use_cassette('sun_frog_add_order') do
        described_class.add_order(order: sun_frog_order.to_hash, batch_id: batch_id)
      end
    end
  end

  describe '#finalize_batch' do
    it 'should finalize the batch' do
      VCR.use_cassette('sun_frog_finalize_batch') do
        described_class.finalize_batch(batch_id: batch_id)
      end
    end
  end

  describe '#end_batch' do
    it 'should end the batch' do
      VCR.use_cassette('sun_frog_end_batch') do
        described_class.end_batch(batch_id: batch_id, paypal_transaction_id: 'trans_id')
      end
    end
  end

  describe 'mockups' do
    def add_mockup
      group_id = nil
      VCR.use_cassette('sun_frog_add_mockup') do
        group_id = described_class.add_mockup(
          image_file: 'some image content?',
          ai_file: 'AI file content?',
          color: 'green',
          type: 'Ladies Tank'
        )
      end
      group_id
    end

    describe '#add_mockup' do
      it 'should add a mockup' do
        add_mockup
      end
    end

    describe '#add_color' do
      it 'should add a color to a mockup' do
        group_id = add_mockup

        VCR.use_cassette('sun_frog_add_color') do
          described_class.add_image(
            group_id: group_id,
            image_file: 'some image content?',
            color: 'green',
            type: 'Ladies Tank'
          )
        end
      end
    end
  end
end
