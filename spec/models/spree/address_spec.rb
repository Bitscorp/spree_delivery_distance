require 'spec_helper'

describe Spree::Address, type: :model do
  describe 'address in specified area' do
    it 'should be ok if address in specified area' do
      a = Spree::Address.new
      expect(a.latitude).not_to be
      expect(a.longitude).not_to be

      DELIVERY_DISTANCE_CONFIG[:distance_delivery_center_address] = 'Barcelona, Spain, 08006'

      a.first_name = 'John'
      a.last_name = 'Watson'
      a.phone = '12345678'
      a.country = Spree::Country.by_iso('ES') ||
        create(:country, name: 'SPAIN', iso_name: "SPAIN", iso: 'es')
      a.city = 'Barcelona'
      a.zipcode = '08006'
      a.address1 = 'Carrer Guillem Tell 37'
      a.save!

      a.reload
      expect(a.latitude).to be
      expect(a.longitude).to be
    end
  end
end
