require 'spec_helper'

describe Spree::Order, type: :model do
  describe 'order in specified area' do
    it 'should be ok if address in specified area' do
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_ltd] = nil
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_lng] = nil
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_address] = 'Barcelona, Spain, 08006'
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_max_distance] = 100

      a = Spree::Address.new
      a.first_name = 'John'
      a.last_name = 'Watson'
      a.phone = '12345678'
      a.country = Spree::Country.by_iso('ES') ||
        create(:country, name: 'SPAIN', iso_name: "SPAIN", iso: 'es')
      a.city = 'Barcelona'
      a.zipcode = '08006'
      a.address1 = 'Carrer Guillem Tell 37'
      a.save!

      order = Spree::Order.new
      order.ship_address = a
      expect(order.errors.empty?).to eq(true)

      order.send(:distance_delivery_ship_address)
      expect(order.errors.empty?).to eq(true)
    end

    it 'should be invalid on ordering out of the area' do
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_ltd] = nil
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_lng] = nil
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_address] = 'Barcelona, Spain, 08006'
      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_max_distance] = 100

      a = Spree::Address.new
      a.first_name = 'John'
      a.last_name = 'Watson'
      a.phone = '12345678'
      a.address1 = 'Street'
      a.zipcode = '85001'
      a.country = Spree::Country.by_iso('US') ||
        create(:country, name: 'USA', iso_name: "USA", iso: 'us')
      a.city = 'Phoenix'
      a.save!

      order = Spree::Order.new
      order.ship_address = a
      expect(order.errors.empty?).to eq(true)
      order.send(:distance_delivery_ship_address)
      expect(order.errors.empty?).to eq(false)
    end
  end
end
