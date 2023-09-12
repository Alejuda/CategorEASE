class Purchase < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :groups

  validates :name, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than: 0 }

  def formatted_date
    created_at.strftime('%Y/%m/%d')
  end
end
