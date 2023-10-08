class Author < ApplicationRecord
    has_many :books

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :date_of_birth, presence: true
    validate :dob_must_be_in_the_past
    validates :about, presence: true, length: { minimum: 10 }
    validates :nationality, presence: true

    def dob_must_be_in_the_past
      if date_of_birth.present? && date_of_birth >= 3.years.ago
        errors.add(:date_of_birth, "date of birth must be in the past")    
      end
    end

    def full_name
      "#{first_name} #{last_name}"
    end

    def age
      ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
    end
end
