class Userreview < ActiveRecord::Base
	validates_presence_of :username, :review_content, :airport_code
	
end
