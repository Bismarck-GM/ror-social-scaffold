require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name(User.name) }
    it { should belong_to(:post).class_name(Post.name) }
  end

  describe 'validations' do
    it {
      should(
        validate_length_of(:content)
          .is_at_most(200)
          .with_long_message('200 characters in comment is the maximum allowed.')
      )
    }
  end
end
