require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  let!(:user1) { User.create name: 'original bender', email: 'bender1@bender.bender', password: 'topsecret' }
  let!(:user2) { User.create name: 'bender clone', email: 'bender2@bender.bender', password: 'potato' }
  let!(:user3) { User.create name: 'bender\'s mom', email: 'bender2@mom.bender', password: 'potato' }

  before(:each) do
    visit user_session_path
    fill_in 'user[email]', with: user1.email
    fill_in 'user[password]', with: user1.password
    click_button 'Log in'
  end

  scenario 'Users should be able to see their posts and their friends\' posts in the timeline ONLY' do
    user1.friendships.create(accepted: true, friend_id: user2.id)
    post1 = user1.posts.create(content: 'user1 post')
    post2 = user2.posts.create(content: 'user2 post')
    post3 = user3.posts.create(content: 'user3 post')
    visit posts_path
    expect(page).to have_content(post1.content)
    expect(page).to have_content(post2.content)
    expect(page).to_not have_content(post3.content)
  end

  scenario 'Users should be able to see the amount of likes and comments on a post' do
    post1 = user1.posts.create(content: 'user1 post')
    post1.likes.create(user_id: user2.id)
    post1.likes.create(user_id: user3.id)
    post1.comments.build(user_id: user3.id, content: 'lorem ipsum dolor sit amet')
    visit posts_path
    expect(page).to have_content('2 likes')
    expect(page).to_not have_content('1 comment')
  end
end
