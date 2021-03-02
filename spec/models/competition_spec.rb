require 'rails_helper'

describe Competition, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:track_path)}
    it {should validate_presence_of(:month)}
    it {should validate_presence_of(:year)}
    it {should validate_presence_of(:description)}
    it {should validate_presence_of(:genre)}
    it {should validate_presence_of(:rules)}
    it {should validate_presence_of(:image)}
  end
  describe 'relationships' do
    it do
      should have_many :verses
    end
  end
end
