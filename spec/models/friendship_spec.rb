require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @sender = User.create(name: 'brannigan', email: 'zackleela@te.com', password: 'password')
    @receiver = User.create(name: 'leela', email: 'fryleela@te.com', password: 'hayaaa')
  end

  describe 'associations' do
    it { should belong_to(:user).class_name(User.name) }
    it { should belong_to(:friend).class_name(User.name) }
  end

  describe 'validations' do
    subject { Friendship.create(user_id: @sender.id, friend_id: @receiver.id, accepted: false) }
    it {
      should validate_uniqueness_of(:user_id)
        .scoped_to(:friend_id)
        .with_message('You\'ve already sent a friend request to this person')
    }
  end

  describe 'custom validations' do
    it 'Should not let you friend yourself' do
      friendship = Friendship.create(user_id: @sender.id, friend_id: @sender.id, accepted: false)
      expect(friendship.errors[' ']).to include("You can't request yourself as a friend. Being lonely is not an excuse")
    end
  end
end
