require 'spec_helper'

describe SunFrog::Models::Order do
  describe '#to_hash' do
    let(:item1) { SunFrog::Models::Item.new(size: 'L', quantity: 5, m: '44091') }
    let(:item2) { SunFrog::Models::Item.new(size: 'M', quantity: 1, m: '44092') }

    let(:order)  { described_class.new(
      email:           "fake@example.com",
      name:            "Fake User",
      address1:        "500 Pine St",
      city:            "Seattle",
      state:           "Washington",
      shipping_zip_code: "98105",
      country:         "United States",
      items:           [item1, item2]
    ) }

    describe 'Email' do
      it {expect(order.to_hash[:email]).to be == order.email}
    end

    describe "Name" do
      it {expect(order.to_hash[:name]).to be == order.name}
    end

    describe "Address" do
      it {expect(order.to_hash[:address1]).to be == order.address1}
    end

    describe "City" do
      it {expect(order.to_hash[:city]).to be == order.city}
    end

    describe "State" do
      it {expect(order.to_hash[:state]).to be == "Washington"}
    end

    describe "ShippingZipCode" do
      it {expect(order.to_hash[:shippingZipCode]).to be == order.shipping_zip_code}
    end

    describe "Country" do
      it {expect(order.to_hash[:country]).to be == "United States"}
    end

    context "Items" do
      describe "M_1" do
        it {expect(order.to_hash[:m_1]).to be == item1.m}
      end

      describe "Size_1" do
        it {expect(order.to_hash[:size_1]).to be == item1.size}
      end

      describe "Quantity_1" do
        it {expect(order.to_hash[:quantity_1]).to be == item1.quantity}
      end

      describe "M_2" do
        it {expect(order.to_hash[:m_2]).to be == item2.m}
      end

      describe "Size_2" do
        it {expect(order.to_hash[:size_2]).to be == item2.size}
      end

      describe "Quantity_2" do
        it {expect(order.to_hash[:quantity_2]).to be == item2.quantity}
      end
    end
  end
end
