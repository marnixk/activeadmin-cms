
class Category < ActiveRecord::Base
  	has_many :articles

	attr_accessible :name, :description, :priority
end

