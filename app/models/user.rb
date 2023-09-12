class User < ApplicationRecord
  has_many :groups, foreign_key: :author_id
  has_many :purchases, foreign_key: :author_id

  validates :name, presence: true, length: { maximum: 100 }
end
