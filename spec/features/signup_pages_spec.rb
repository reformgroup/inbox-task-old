require 'rails_helper'
include ApplicationHelper
include CssSpecHelper
include SessionsSpecHelper

RSpec.feature 'signup', type: :features do
  let(:submit) { 'Зарегистрироваться' }
  let(:signup) { 'Регистрация' }
  let(:logout) { 'Выйти' }
  let(:user) { build(:user) }
  
  before { visit signup_path }
  
  context 'page' do
    scenario { expect(page).to have_link(signup) }
    scenario { expect(page).to have_title(full_title(signup)) }
  end
  describe 'signup' do
    describe 'with invalid information' do
      scenario { expect{ click_button submit }.not_to change(User, :count) }
      
      context 'after submission' do
        before { click_button submit }
        
        scenario { expect(page).to have_title(full_title(signup)) }
        scenario { expect(page).to have_css(li_danger_css) }
      end
    end
    
    describe 'with valid information' do
      before do
        fill_in 'user[first_name]',                         with: user.first_name
        fill_in 'user[last_name]',                          with: user.last_name
        fill_in 'user[email]',                              with: user.email
        fill_in 'user[password]',                           with: user.password
        fill_in 'user[password_confirmation]',              with: user.password
        select I18n.l(user.birth_date, format: '%-d'), from: 'user_birth_date_3i'
        select I18n.l(user.birth_date, format: '%B'),  from: 'user_birth_date_2i'
        select I18n.l(user.birth_date, format: '%Y'),  from: 'user_birth_date_1i'
        choose 'user_gender_male'
      end
      
      scenario { expect { click_button submit }.to change(User, :count).by(1) }
      
      context 'after submission' do
        before { click_button submit }
        
        scenario { expect(page).not_to have_link(signup) }
        scenario { expect(page).not_to have_css(li_danger_css) }
        scenario { expect(page).to have_title(full_title(user.short_name)) }
        scenario { expect(page).to have_content(user.name) }
        scenario { expect(page).to have_selector(alert_success_css) }
        scenario { expect(page).to have_link(logout) }
      end
    end
  end
end
