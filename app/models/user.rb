class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable, :omniauth_providers => [:fitbit]

    def self.from_omniauth(auth)
        #throw auth.inspect
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            #user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            #user.save!
            #fitbit_data
        end
    end
    
    # def linked?
    	# oauth_token.present? && oauth_secret.present?
    # end

  	def fitbit_data
	    # raise "Account is not linked with a Fitbit account" unless linked?
	    @client ||= Fitgem::Client.new(
	                :consumer_key => ENV["FITBIT_CONSUMER_KEY"],
	                :consumer_secret => ENV["FITBIT_CONSUMER_SECRET"],
	                :token => oauth_token,
	                :secret => oauth_secret,
	                :user_id => uid,
	                :ssl => true
	              )
	 	throw @client.inspect
  	end
    
end
