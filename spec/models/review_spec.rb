require 'rails_helper'

RSpec.describe Review, type: :model do

  it 'is invalid if rating is over 5' do
    review = Review.new(rating: 10)
    expect(review).to have(1).error_on(:rating)
  end



end
