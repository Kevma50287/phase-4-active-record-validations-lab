class Author < ApplicationRecord
    validates_presence_of :name
    validates_uniqueness_of :name
    validates :phone_number, length: {is:10}
end
