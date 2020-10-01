module SpreeDeliveryDistance
  module Spree
    module OrderDecorator
      def self.prepended(base)
        base.after_validation :distance_delivery_ship_address, on: [:create, :update]
      end

      def distance_delivery_ship_address
        return if ship_address.nil?

        if ship_address.latitude.blank? || ship_address.longitude.blank?
          ship_address.geocode
          ship_address.save
        end

        distance = ship_address.distance_to(DELIVERY_DISTANCE_CONFIG.distance_delivery_center).to_f
        max_distance = DELIVERY_DISTANCE_CONFIG.distance_delivery_center_max_distance.to_f
        return unless distance > max_distance

        errors.add :ship_address, :address_is_too_far
      end
    end
  end
end

if ::Spree::Order.included_modules.exclude?(SpreeDeliveryDistance::Spree::OrderDecorator)
  ::Spree::Order.prepend SpreeDeliveryDistance::Spree::OrderDecorator
end
