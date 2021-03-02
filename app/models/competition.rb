class Competition < ApplicationRecord
  validates_presence_of :track_path, 
                        :month, 
                        :year, 
                        :description, 
                        :genre, 
                        :rules, 
                        :image 
  has_many :verses
end
