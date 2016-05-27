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

    scenario 'user can navigate back to restaurants list' do
      visit '/restaurants'
      click_link 'Meatballs'
      click_link 'Back'
      expect(current_path). to eq "/restaurants"
    end
  end

  context 'updating a restaurant' do

    before { Restaurant.create name: 'Meatballs', description: 'Best meatballs'}

    scenario 'a user can update a restaurant' do
      visit '/restaurants'
      click_link 'Edit Meatballs'
      fill_in :Name, with: 'Meatballs 2'
      fill_in :Description, with: 'Legit meatballs lol'
      click_button 'Update restaurant'
      expect(page).to have_content 'Meatballs'
      expect(page).to have_content 'Legit meatballs lol'
    end

  end

  context 'deleting a restaurant' do

    before { Restaurant.create name: 'Meatballs', description: 'Best meatballs'}

    scenario 'removes a restaurant when a user clicks a delete link' do
      visit '/restaurants'
      click_link 'Delete Meatballs'
      expect(page).not_to have_content 'Meatballs'
      expect(page).to have_content 'Restaurant deleted'
    end

    scenario 'can delete a restaurant with a review' do
      visit '/restaurants'
      click_link 'Review Meatballs'
      fill_in :Thoughts, with: 'Great'
      select 4, from: 'Rating'
      click_button 'Add review'
      click_link 'Delete Meatballs'
      expect(page).to have_content 'Restaurant deleted'
      expect(page).not_to have_content 'Meatballs'
    end

  end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add Restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Add'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end
  end

end

feature 'reviewing' do

  before { Restaurant.create name: 'Meatballs' }

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review Meatballs'
    fill_in 'Thoughts', with: 'Pretty great lol'
    select 4, from: 'Rating'
    click_button 'Add review'
    expect(current_path).to eq '/restaurants'
    click_link 'Meatballs'
    expect(page).to have_content 'Pretty great lol'
  end

end

feature 'limits on user actions' do

  context 'when not signed in' do

    scenario 'should not be able to see Add restaurant link' do
      visit '/restaurants'
      expect(page).not_to have_content 'Add Restaurant'
    end

    scenario 'should not be able to add a restaurant from /new path' do
      visit '/restaurants/new'
      fill_in :Name, with: 'Alex\'s Pizza Palace'
      fill_in :Rating, with: 4
      click_button 'Add'
      expect(page).to have_content 'Must be signed in'
      expect(page).not_to have_content 'Alex\'s Pizza Palace'
    end

    xscenario 'should not be able to add a review' do

    end

  end

  context 'when signed in' do

    scenario 'can only see edit link for restaurants they have created' do
      sign_up_user_1
      add_restaurant
      click_link 'Sign out'
      sign_up_user_2
      expect(page).not_to have_content 'Edit Popeyes'
    end

    scenario 'cannot edit restaurants they have not created from /update' do
      sign_up_user_1
      add_restaurant
      click_link 'Sign out'
      sign_up_user_2
      visit '/restaurants/1/edit'
      fill_in :Name, with: 'KFC'
      fill_in :Rating, with: 4
      fill_in :Description, with: 'Legit chicken'
      click_button 'Update restaurant'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'You do not have permission to edit this restaurant'
    end

    scenario 'can only leave one review per restaurant' do
      
    end

    scenario 'can only delete their own reviews' do

    end

  end



end
