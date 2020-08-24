require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
    it { should have_many(:posts) }
    it { should have_many(:friendships) }
    it { should have_many(:friends).conditions(friendships: { accepted: true }).through(:friendships).source(:user) }
    it { should have_many(:received_friend_requests).conditions(friendships: { accepted: false }).through(:reverse_friendships).source(:user) }
    it { should have_many(:sent_friend_requests).conditions(friendships: { accepted: false }).through(:friendships).source(:user) }
  end

  describe 'validations' do
    it { should validate_length_of(:name).is_at_most(20) }
    it { should validate_presence_of(:name) }
  end
end
