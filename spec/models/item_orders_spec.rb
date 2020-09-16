require 'rails_helper'

describe ItemOrder, type: :model do
  describe "validations" do
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'instance methods' do
    it 'subtotal' do
      user = User.create(email: "c_j@email.com", password: "test", name: "Mike Dao", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 0)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)

      expect(item_order_1.subtotal).to eq(200)
    end

    describe "Updates item's inventory after order cancellation" do
      it "#update_inventory" do
        user = User.create(email: "c_j@email.com", password: "test", name: "Mike Dao", city: "blah", state: "blah", street_address: "blah", zip: 12345, role: 0)
        meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

        tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
        
        order_1 = user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
        item_order_1 = order_1.item_orders.create!(item: tire, price: tire.price, quantity: 2)
        item_order_1.update_inventory
        
        expect(tire.inventory).to eq(14)
      
      end
    end
  end

end
