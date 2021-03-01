require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it do
      should validate_uniqueness_of :email
    end
  end
  
  describe 'relationships' do
    it do
      should have_many :verses
      should have_many(:user_votes).through(:votes)
    end
  end
end
