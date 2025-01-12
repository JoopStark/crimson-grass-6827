require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many (:customer_items) }
    it { should have_many(:customers).through(:customer_items)  }
  end

  describe "count_customets" do
    it "can count the number of customers an item has" do
      abel = Customer.create!(name: "Abel")
      blake = Customer.create!(name: "Blake")
      cici = Customer.create!(name: "Cici")

      albertsons = Supermarket.create!(name: "Albertsons", location: "Denver")
      bingos = Supermarket.create!(name: "Bingos", location: "Denver")

      apple = albertsons.items.create!(name: "apple", price: 1)
      bread = albertsons.items.create!(name: "bread", price: 2)
      corn = albertsons.items.create!(name: "corn", price: 4)
      donut = bingos.items.create!(name: "donut", price: 8)
      eggs = bingos.items.create!(name: "eggs", price: 16)

     CustomerItem.create!(customer: blake, item: apple)
     CustomerItem.create!(customer: abel, item: bread)
     CustomerItem.create!(customer: blake, item: corn)
     CustomerItem.create!(customer: abel, item: corn)
     CustomerItem.create!(customer: cici, item: corn)
     CustomerItem.create!(customer: blake, item: donut)

     expect(corn.count_customers).to eq(3)
     expect(eggs.count_customers).to eq(0)
    end
  end
end