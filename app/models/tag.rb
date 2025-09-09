class Tag < ApplicationRecord
 validates :name, presence: true,  length: { maximum: 100 }, uniqueness: { case_sensitive: false }
 validates :status, presence: false, inclusion: { in: [ true, false ] }
end
