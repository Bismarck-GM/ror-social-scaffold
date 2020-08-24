require 'rails_helper'

RSpec.describe 'Friendships', type: :feature do
  let!(:user1) { User.create name: 'original bender', email: 'bender1@bender.bender', password: 'topsecret' }
  let!(:user2) { User.create name: 'bender clone', email: 'bender2@bender.bender', password: 'potato' }

  before(:each) do
    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'Log in'
  end

  scenario 'Should show received pending friendships' do
    user1.reverse_friendships.create(accepted: false, user_id: user2.id)
    visit friendships_path
    expect(page).to have_content(user2.name)
  end

  scenario 'Should allow users to send friendships to other users' do
    visit users_path
    find(:xpath, "//a[@href='#{user_friendships_path(user2)}']").click
    expect(page).to have_content('Friend request was sent successfully.')
    friendship = Friendship.find_by(user_id: user1.id, friend_id: user2.id, accepted: false)
    expect(friendship).to_not be(nil)
  end

  scenario 'Should not allow a user to friend request themselves' do
    visit users_path
    find(:xpath, "//a[@href='#{user_friendships_path(user1)}']").click
    expect(page).to have_content('You can\'t request yourself as a friend. Being lonely is not an excuse')
  end

  scenario 'Should allow users to accept friendships' do
    user1.reverse_friendships.create(accepted: false, user_id: user2.id)
    visit friendships_path
    find(:xpath, "//a[@href='#{user_friendships_accept_path(user2)}']").click
    expect(page).to have_content('Friendship accepted successfully.')
    friendship = Friendship.find_by(user_id: user2.id, friend_id: user1.id, accepted: true)
    expect(friendship).to_not be(nil)
  end

  scenario 'Should allow users to reject friendshpis' do
    user1.reverse_friendships.create(accepted: false, user_id: user2.id)
    visit friendships_path
    find(:xpath, "//a[@href='#{user_friendships_reject_path(user2)}']").click
    expect(page).to have_content('Friendship rejected successfully.')
    friendship = Friendship.find_by(user_id: user2.id, friend_id: user1.id, accepted: true)
    expect(friendship).to be(nil)
  end
end
