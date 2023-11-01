class Synonym < ApplicationRecord
    validates :word, presence: true
    validates :synonym, presence: true
    before_save :set_default_approved

    private
    def set_default_approved
        self.approved = false if self.approved.nil?
    end
end
