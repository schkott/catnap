class WelcomeController < ApplicationController
  def index
  	@client = current_user.fitbit_data
  	@daily_activities = @client.activities_on_date 'today'
  	# render :text => @daily_activities
  end
end
