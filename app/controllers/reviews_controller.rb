class ReviewsController < ApplicationController
	def createreview
		airportreview = Airportreview.new(params[:revs])
		if airportreview.save
			res={:success=>true,:content=>"Review Saved!"}
		else
			res={:success=>false,:content=>"Unable to save review"}
		end
		render :text=>res.to_json
	
	end
 	
end
