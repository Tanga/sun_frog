module SunFrog
  module Models
    class Item
      attr_accessor :size, :quantity, :m

      def initialize(size:, quantity:, m:)
        @size     = size
        @quantity = quantity
        @m        = m
      end
    end
  end
end
