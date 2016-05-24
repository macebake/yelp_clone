require 'rails_helper'

feature 'restaurants' do
  context 'no restaurants have been added'

    scenario 'displays message when no restaurants have been added' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants found'
      expect(page).to have_link 'Add Restaurant'
    end

    scenario ''

  end

end
