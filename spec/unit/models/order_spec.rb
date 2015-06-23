require 'rails_helper'

describe Fulfiller::SunFrog::Models::Order do
  describe '#to_hash' do
    let(:item)            { ApiModels::Item.make }
    let(:shipment)        { ApiModels::Shipment.make(items: [item]) }
    let(:order)           { ApiModels::Order.make(shipments: [shipment]) }
    let(:sun_frog_order)  { described_class.new(order) }

    describe 'Email' do
      it {expect(sun_frog_order.to_hash[:email]).to be == order.email_address}
    end

    describe "Name" do
      it {expect(sun_frog_order.to_hash[:name]).to be == "#{order.billing_address.first_name} #{order.billing_address.last_name}"}
    end

    describe "Address" do
      it {expect(sun_frog_order.to_hash[:address1]).to be == order.billing_address.address1}
    end

    describe "City" do
      it {expect(sun_frog_order.to_hash[:city]).to be == order.billing_address.city}
    end

    describe "State" do
      it {expect(sun_frog_order.to_hash[:state]).to be == "Washington"}
    end

    describe "ShippingZipCode" do
      it {expect(sun_frog_order.to_hash[:shippingZipCode]).to be == order.billing_address.postal_code}
    end

    describe "Country" do
      it {expect(sun_frog_order.to_hash[:country]).to be == "United States"}
    end

    context "Items" do
      describe "M_1" do
        it {expect(sun_frog_order.to_hash[:m_1]).to be == '44091'}
      end

      describe "Size_1" do
        it {expect(sun_frog_order.to_hash[:size_1]).to be == item.variants["Size"]}
      end

      describe "Quantity_1" do
        it {expect(sun_frog_order.to_hash[:quantity_1]).to be == item.quantity }
      end
    end
  end
end
