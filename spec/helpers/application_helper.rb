module ApplicationHelper

  def sign_up_user_1
    visit '/restaurants'
    click_link 'Sign up'
    fill_in 'Email', with: 'm@cey.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Sign up'
  end

  def sign_up_user_2
    visit '/restaurants'
    click_link 'Sign up'
    fill_in 'Email', with: 'a@lex.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Sign up'
  end

  def add_restaurant
    click_link 'Add Restaurant'
    fill_in 'Name', with: 'Popeyes'
    fill_in 'Rating', with: 5
    click_button 'Add'
  end

end
