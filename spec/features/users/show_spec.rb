require 'rails_helper'
RSpec.describe 'users show page' do
  it 'has user name, button to discover movies & section that lists viewing parties' do
    user_1 = User.create!(name: 'user_1', email: 'email@gmail.com')
    user_2 = User.create!(name: 'user_2', email: 'test@gmail.com')
    user_3 = User.create!(name: 'user_3', email: 'test_2@gmail.com')
    party_1 = Party.create!(date: '2022-02-06', duration: 160, start_time: '7:00', movie: 'Jurasic Park',
                            host: user_1.id)
    party_2 = Party.create!(date: '2022-02-05', duration: 160, start_time: '7:00', movie: 'Star Wars')
    user_party_1 = UserParty.create!(user_id: user_1.id, party_id: party_1.id)
    user_party_2 = UserParty.create!(user_id: user_2.id, party_id: party_1.id)
    user_party_3 = UserParty.create!(user_id: user_3.id, party_id: party_1.id)
    user_party_2 = UserParty.create!(user_id: user_1.id, party_id: party_2.id)
    visit user_path(user_1)
    within '.name' do
      expect(page).to have_content(user_1.name)
    end
    within '.discover_movies' do
      expect(page).to have_button('Discover Movies')
    end
    within '.viewing_parties' do
      expect(page).to have_content(party_1.movie)
      expect(page).to have_content(party_1.movie)
    end
    within '.discover_movies' do
      click_button('Discover Movies')
      expect(current_path).to eq("/users/#{user_1.id}/discover")
    end

    visit user_path(user_1)
    within ".invites-#{party_1.id}" do
      host_in_bold = find(".#{user_1.name}")
      expect(page).to have_content(user_1.name)
      expect(page).to have_content(user_2.name)
      expect(host_in_bold).to have_css(user_1.name, text: 'bold')
    end
  end
end
