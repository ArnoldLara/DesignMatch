class Project < ApplicationRecord
  belongs_to :admin
  has_many :designs
end
