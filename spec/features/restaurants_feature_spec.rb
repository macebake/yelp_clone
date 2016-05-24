require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added' do

    scenario 'displays message when no restaurants have been added' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants found'
      expect(page).to have_link 'Add Restaurant'
    end

  end

  context 'restaurants have been added' do
    before do
      Restaurant.create name:'Michael\'s Crab Shack'
    end

    scenario 'displays the restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'Michael\'s Crab Shack'
      expect(page).not_to have_content 'No restaurants found'
      expect(page).to have_link 'Add Restaurant'
    end

  end

end
