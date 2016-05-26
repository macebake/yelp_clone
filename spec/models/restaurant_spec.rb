require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: 'kf')
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid if restaurant name is not unique' do
    Restaurant.create(name: "Meatballs")
    restaurant = Restaurant.new(name: "Meatballs")
    expect(restaurant).to have(1).error_on(:name)
  end
end
