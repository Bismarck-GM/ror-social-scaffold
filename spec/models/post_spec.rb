require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:user).class_name(User.name) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:likes).dependent(:destroy) }
  end

  describe 'validations' do
    it {
      should(
        validate_length_of(:content)
          .is_at_most(1000)
          .with_long_message('1000 characters in post is the maximum allowed.')
      )
    }
    it { should validate_presence_of(:content) }
  end
end
