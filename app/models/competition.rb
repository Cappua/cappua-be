class Competition < ApplicationRecord
  validates_presence_of :track_path,
                        :month,
                        :year,
                        :description,
                        :genre,
                        :rules,
                        :image,
                        :title
  has_many :verses
end
