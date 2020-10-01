require 'spec_helper'

describe SpreeDeliveryDistance::Spree::DeliveryDistanceConfiguration, type: :model do
  describe 'Rails preferences' do

    it 'should have and store settings for deliveries' do
      prefs = SpreeDeliveryDistance::Spree::DeliveryDistanceConfiguration.new
      expect(prefs).to have_preference(:distance_delivery_center_lng)
      expect(prefs).to have_preference(:distance_delivery_center_ltd)
      expect(prefs).to have_preference(:distance_delivery_center_max_distance)
    end

    it 'should return lng, ltd as array of coordinates' do
      prefs = SpreeDeliveryDistance::Spree::DeliveryDistanceConfiguration.new
      prefs.distance_delivery_center_address = nil
      prefs.distance_delivery_center_lng = 2.0
      prefs.distance_delivery_center_ltd = 1.0
      center = prefs.distance_delivery_center
      expect(center).to eq([1.0, 2.0])
    end

    it 'should return lng, ltd as array of coordinates by address' do
      prefs = SpreeDeliveryDistance::Spree::DeliveryDistanceConfiguration.new
      prefs.distance_delivery_center_address = 'Barcelona, Spain'
      prefs.distance_delivery_center_lng = nil
      prefs.distance_delivery_center_ltd = nil

      center = prefs.distance_delivery_center
      expect(center.blank?).to eq(false)
    end
  end
end
