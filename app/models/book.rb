class Book < ApplicationRecord
  belongs_to :author
  belongs_to :publisher

  validates :title, presence: true
  validates :isbn, presence: true, format: {with: /[0-9]{13}/}
  validates :date_of_publication, presence: true
  validate :dop_must_be_in_past
  validates :review, presence: true, length: { minimum: 15, maximum: 400 }
  validates :price, presence: true, comparison: {greater_than: 0.00}

  def dop_must_be_in_past
    if :date_of_publication > Date.Today
      errors.add(:date_of_publication, "the date of publication must be in the past")
    end
  end
end
