require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('user@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    context 'password validations' do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6) }

      it 'requires password confirmation to match' do
        user = build(:user, password: 'password123', password_confirmation: 'different')
        expect(user).not_to be_valid
        expect(user.errors[:password_confirmation]).to include("doesn't match Password")
      end
    end
  end

  describe 'associations' do
    it { should have_many(:posts).dependent(:destroy) }
    it { should have_many(:comments).class_name('Comments::Comment').dependent(:destroy) }
  end

  describe 'Devise modules' do
    it 'includes database_authenticatable' do
      expect(User.devise_modules).to include(:database_authenticatable)
    end

    it 'includes registerable' do
      expect(User.devise_modules).to include(:registerable)
    end

    it 'includes recoverable' do
      expect(User.devise_modules).to include(:recoverable)
    end

    it 'includes rememberable' do
      expect(User.devise_modules).to include(:rememberable)
    end

    it 'includes validatable' do
      expect(User.devise_modules).to include(:validatable)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'creates a user with valid attributes' do
      user = create(:user)
      expect(user).to be_persisted
      expect(user.email).to be_present
      expect(user.encrypted_password).to be_present
    end
  end

  describe 'email uniqueness' do
    let!(:existing_user) { create(:user, email: 'test@example.com') }

    it 'does not allow duplicate emails' do
      duplicate_user = build(:user, email: 'test@example.com')
      expect(duplicate_user).not_to be_valid
      expect(duplicate_user.errors[:email]).to include('has already been taken')
    end

    it 'is case insensitive' do
      duplicate_user = build(:user, email: 'TEST@EXAMPLE.COM')
      expect(duplicate_user).not_to be_valid
    end
  end

  describe 'associations behavior' do
    let(:user) { create(:user) }

    context 'with posts' do
      let!(:post1) { create(:post, user: user) }
      let!(:post2) { create(:post, user: user) }

      it 'returns associated posts' do
        expect(user.posts).to contain_exactly(post1, post2)
      end

      it 'destroys posts when user is destroyed' do
        expect { user.destroy }.to change { Post.count }.by(-2)
      end
    end

    context 'with comments' do
      let!(:other_user_post) { create(:post) }
      let!(:comment1) { create(:comment, user: user, post: other_user_post) }
      let!(:comment2) { create(:comment, user: user, post: other_user_post) }

      it 'returns associated comments' do
        expect(user.comments).to contain_exactly(comment1, comment2)
      end

      it 'destroys comments when user is destroyed' do
        expect { user.destroy }.to change { Comments::Comment.count }.by(-2)
      end
    end
  end

  describe 'password encryption' do
    it 'encrypts password on create' do
      user = create(:user, password: 'secret123', password_confirmation: 'secret123')
      expect(user.encrypted_password).to be_present
      expect(user.encrypted_password).not_to eq('secret123')
    end

    it 'authenticates with correct password' do
      user = create(:user, password: 'secret123', password_confirmation: 'secret123')
      expect(user.valid_password?('secret123')).to be true
    end

    it 'does not authenticate with incorrect password' do
      user = create(:user, password: 'secret123', password_confirmation: 'secret123')
      expect(user.valid_password?('wrong_password')).to be false
    end
  end

  describe 'factory traits' do
    context 'with_posts trait' do
      it 'creates user with posts' do
        user = create(:user, :with_posts, posts_count: 5)
        expect(user.posts.count).to eq(5)
      end
    end

    context 'with_comments trait' do
      it 'creates user with comments' do
        user = create(:user, :with_comments, comments_count: 3)
        expect(user.comments.count).to eq(3)
      end
    end
  end
end
