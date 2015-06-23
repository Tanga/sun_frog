module Fulfiller
  module SunFrog
    module Models
      class Batch
        attr_accessor :batch_id

        def initialize(api_client: Fulfiller::SunFrog::ApiClient)
          @api_client = api_client
          @batch_id   = nil
        end

        def process(orders:)
          orders.each do |order|
            add_order(order: order)
          end

          finalize(paypal_transaction_id: 'FAKE TRANSACTION ID')
        end

        def add_order(order:)
          start unless @batch_id.present?
          @api_client.add_order(order: order, batch_id: @batch_id)
        end

        def finalize(paypal_transaction_id:)
          @api_client.finalize_batch(batch_id: @batch_id)
          @api_client.end_batch(batch_id: @batch_id, paypal_transaction_id: paypal_transaction_id)
        end

        def clear
          @api_client.clear_batch(batch_id: @batch_id)
        end

      private

        def start
          response  = @api_client.start_batch
          @batch_id = response.first[:BatchID]
        end
      end
    end
  end
end
