class Group < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :purchases

  validates :name, presence: true, length: { maximum: 100 }
  validates :icon, presence: true

  def total_amount
    purchases.sum(:amount)
  end
end
