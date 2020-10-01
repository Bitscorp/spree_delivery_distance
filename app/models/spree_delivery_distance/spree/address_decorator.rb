module SpreeDeliveryDistance
  module Spree
    module AddressDecorator
      def self.prepended(base)
        base.geocoded_by :full_address do |obj, results|
          geo = results.first

          if geo
            obj.latitude = geo.latitude
            obj.longitude = geo.longitude
          else
            obj.errors.add :base, :cant_geocode
          end
        end

        base.after_validation :geocode, on: [:create, :update]
      end

      ##
      # The full address.
      #
      # @example Get the full address.
      #   address.full_address # "street, city, state, country"
      #
      # @return [String] The full street address wit city, state and country.
      #
      def full_address
        [address1, address2.presence, city, state_text, country.try(:iso)].compact.join(', ')
      end
    end
  end
end

if ::Spree::Address.included_modules.exclude?(SpreeDeliveryDistance::Spree::AddressDecorator)
  ::Spree::Address.prepend SpreeDeliveryDistance::Spree::AddressDecorator
end
