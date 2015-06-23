module SunFrog
  module Models
    class Order
      attr_accessor :items, :city, :address1, :email, :shipping_zip_code, :name

      def initialize(attributes={})
        @email         = attributes[:email]
        @name          = attributes[:name]
        @address1      = attributes[:address1]
        @state         = attributes[:state]
        @shipping_zip_code = attributes[:shipping_zip_code]
        @items         = attributes[:items] || []
      end

      def to_hash
        order_hash_with_variants
      end

      private

      def order_hash
        { email:           @email,
          name:            @name,
          address1:        @address1,
          city:            @city,
          state:           @state,
          shippingZipCode: @shipping_zip_code,
          country:         country }
      end

      def order_hash_with_variants
        order_hash.tap do |order|
          @items.each.with_index(1) do |item, index|
            order["size_#{index}".to_sym]     = item.size
            order["quantity_#{index}".to_sym] = item.quantity
            order["m_#{index}".to_sym]        = item.m
          end
        end
      end


      def country
        'United States'
      end
    end
  end
end
