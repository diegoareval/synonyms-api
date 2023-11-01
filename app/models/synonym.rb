class Synonym < ApplicationRecord
    validates :word, presence: true
    validates :synonym, presence: true
    validates :approved, inclusion: { in: [true, false] }
end
