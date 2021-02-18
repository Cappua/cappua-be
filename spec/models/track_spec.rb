require 'rails_helper'

describe Track, type: :model do
  describe 'relationships' do
    it do
      should have_many :verses
    end
  end
end
