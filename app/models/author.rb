class Author < ApplicationRecord
    has_many :books

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    validate :dob_must_be_in_the_past
    validates :about, presence: true, length: { minimum: 10 , maximum: 250 }
    validates :nationality, presence: true

    def dob_must_be_in_the_past
      if date_of_birth >= 3.years.ago
        errors.add(:date_of_birth, "date of birth must be in the past")    
      end
    end
end
