class User < ApplicationRecord
  has_many :groups
  has_many :purchases

  validates :name, presence: true, length: { maximum: 100 }
end
