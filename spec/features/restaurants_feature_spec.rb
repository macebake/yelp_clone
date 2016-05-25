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

  context 'adding a restaurant' do

    scenario 'adds a new restaurant' do
      visit '/restaurants'
      click_link 'Add Restaurant'
      expect(current_path).to eq '/restaurants/new'
      fill_in :Name, with: 'Macey\'s Meatballs'
      fill_in :Rating, with: 5
      click_button 'Add'
      expect(current_path).to eq '/restaurants'
      expect(page).to have_content 'Macey\'s Meatballs'
      expect(page).to have_content '5'
    end

  end

  context 'viewing a restaurant' do
    let!(:meatballs) {Restaurant.create(name: 'Meatballs', rating: 5)}

    scenario 'user can click on restaurant to view details' do
      visit '/restaurants'
      click_link 'Meatballs'
      expect(page).to have_content 'Meatballs'
      expect(current_path).to eq "/restaurants/#{meatballs.id}"
    end
  end

end
