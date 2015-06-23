require 'httparty'

module Fulfiller
  module SunFrog
    module ApiClient
      include HTTParty
      base_uri "https://staging.sunfrogshirts.com/v1"
      format :json

      class << self
        def start_batch
          api_post("/Orders/#{profile_id}/startBatch.json", default_params)
        end

        def add_order(order:, batch_id:)
          params = order.to_hash.merge(default_params).merge(batchID: batch_id)
          api_post("/Orders/#{profile_id}/addOrder.json", params)
        end

        def finalize_batch(batch_id:)
          api_post("/Orders/#{profile_id}/finalizeBatch.json", default_params.merge(batchID: batch_id))
        end

        def end_batch(batch_id:, paypal_transaction_id:)
          params = default_params.merge(batchID: batch_id, transactionID: paypal_transaction_id)
          api_post("/Orders/#{profile_id}/endBatch.json", params)
        end

        def clear_batch(batch_id:)
          api_post("/Orders/#{profile_id}/clearBatch.json", default_params.merge(batchID: batch_id))
        end

        def add_mockup(image_file:, ai_file:, color:, type:)
          params = default_params.merge(imageFile: image_file, AiFile: ai_file, Color: color, MockupType: type)
          api_post("/Mockups/#{profile_id}/addMockup.json", params)
        end

        def add_image(group_id:, image_file:, color:, type:)
          params = default_params.merge(imageFile: image_file, Group: group_id, Color: color, MockupType: type)
          api_post("/Mockups/#{profile_id}/addImage.json", params)
        end

        private

        def api_post(path, params={})
          post(path, body: params, basic_auth: basic_auth)
        end

        def default_params
          { "Iagree" => 1, "username" => username, "password" => password }
        end

        # TODO: Move these to someplace else
        def username
          'jerry@tanga.com'
        end

        def password
          '33xtv12nb8'
        end

        # TODO: Username/password are different from our API keys
        def basic_auth
          { username: 'TANGA8463', password: 'fz3g86gtr467hg' }
        end

        def profile_id
          'FGFWGWFD'
        end
      end
    end
  end
end
