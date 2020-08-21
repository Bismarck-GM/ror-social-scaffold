require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name(User.name) }
    it { should belong_to(:post).class_name(Post.name) }
  end

  describe 'validations' do
    subject do
      Comment.create({
                     content: 'Bender rolling in the deep',
                   })
    end

    it { should validate_length_of(:content).is_at_most(200) }
  end
end