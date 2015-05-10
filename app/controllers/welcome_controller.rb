class WelcomeController < ApplicationController
  def index
  	@client = current_user.fitbit_data
    @weekly_cals = []
    @weekly_sleep = []
  	(6.days.ago.to_date..Date.today).each do |day|
  	  @daily_activities = @client.activities_on_date(day)
  	  @daily_cals =  (@daily_activities['summary']['caloriesOut']).to_i
  	  @daily_sleep = (@client.sleep_on_date(day)['summary']['totalMinutesAsleep']).to_i/60
  	  @weekly_cals.push(@daily_cals)
  	  @weekly_sleep.push(@daily_sleep)
  	end
  	@today = @client.activities_on_date 'today'
  	@todayBurnGoal = (@today['goals']['caloriesOut']).to_i
  	@todayBurned = (@today['summary']['caloriesOut']).to_i
  	@todayStepGoal = (@today['goals']['steps']).to_i
  	@todaySteps = (@today['summary']['steps']).to_i
  	@todaySleep = (@client.sleep_on_date('today')['summary']['totalMinutesAsleep']).to_i/60
  	puts @todayBurnGoal
  	puts @todayBurned
  	puts @todayStepGoal
  	puts @todaySteps
  	puts @todaySleep
  end
end
