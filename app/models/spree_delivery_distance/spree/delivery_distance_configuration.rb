require 'geocoder'

module SpreeDeliveryDistance
  module Spree

    class DeliveryDistanceConfiguration < ::Spree::Preferences::Configuration
      preference :distance_delivery_center_enabled, :boolean, default: true
      preference :distance_delivery_center_lng, :float, default: nil
      preference :distance_delivery_center_ltd, :float, default: nil
      preference :distance_delivery_center_max_distance, :float, default: 60.0
      preference :distance_delivery_center_address, :string, default: nil

      def distance_delivery_center
        return unless distance_delivery_center_enabled

        if distance_delivery_center_ltd.nil? || distance_delivery_center_lng.nil?
          if distance_delivery_center_address.blank?
            raise 'missing distance_delivery_center_address'
          end

          results = Geocoder.search(distance_delivery_center_address)
          if results.blank?
            raise 'configure properly distance_delivery_center_address'
          end
          location = results.first
          distance_delivery_center_ltd, distance_delivery_center_lng =
            location.latitude, location.longitude
        else
          [
            distance_delivery_center_ltd,
            distance_delivery_center_lng
          ]
        end
      end
    end

    #
    # Example:
    #
    # DD_CONFIG = SpreeDeliveryDistance::Spree::DeliveryDistanceConfiguration.new
    #
  end
end
