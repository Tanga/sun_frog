module Fulfiller
  module SunFrog
    module Models
      STATES = {AK: "Alaska", AL: "Alabama", AR: "Arkansas", AS: "American Samoa", AZ: "Arizona", CA: "California", CO: "Colorado", CT: "Connecticut", DC: "District of Columbia", DE: "Delaware", FL: "Florida", GA: "Georgia", GU: "Guam", HI: "Hawaii", IA: "Iowa", ID: "Idaho", IL: "Illinois", IN: "Indiana", KS: "Kansas", KY: "Kentucky", LA: "Louisiana", MA: "Massachusetts", MD: "Maryland", ME: "Maine", MI: "Michigan", MN: "Minnesota", MO: "Missouri", MS: "Mississippi", MT: "Montana", NC: "North Carolina", ND: "North Dakota", NE: "Nebraska", NH: "New Hampshire", NJ: "New Jersey", NM: "New Mexico", NV: "Nevada", NY: "New York", OH: "Ohio", OK: "Oklahoma", OR: "Oregon", PA: "Pennsylvania", PR: "Puerto Rico", RI: "Rhode Island", SC: "South Carolina", SD: "South Dakota", TN: "Tennessee", TX: "Texas", UT: "Utah", VA: "Virginia", VI: "Virgin Islands", VT: "Vermont", WA: "Washington", WI: "Wisconsin", WV: "West Virginia", WY: "Wyoming" }

      class Order
        def initialize(order)
          @order     = order
          @address   = order.billing_address
          @shipments = order.shipments
        end

        def to_hash
          order_hash_with_variants
        end

        private

        def order_hash
          { email:           @order.email_address,
            name:            full_name,
            address1:        @address.address1,
            city:            @address.city,
            state:           STATES[@address.province.to_sym],
            shippingZipCode: @address.postal_code,
            country:         country }
        end

        def order_hash_with_variants
          order_hash.tap do |order|
            @shipments.each do |shipment|
              shipment.items.each.with_index(1) do |item, index|
                order["size_#{index}".to_sym]     = item.variants["Size"].strip
                order["quantity_#{index}".to_sym] = item.quantity
                order["m_#{index}".to_sym]        = '44091'
              end
            end
          end
        end

        def full_name
          "#{@address.first_name} #{@address.last_name}"
        end

        def country
          if @address.country == 'US'
            'United States'
          end
        end
      end
    end
  end
end
