class User < ActiveRecord::Base
  require 'securerandom'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable, :omniauth_providers => [:fitbit]

    def self.from_omniauth(auth)
        #throw auth['credentials']['secret']
        user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.password = Devise.friendly_token[0,20]
        end
		 		user.email = SecureRandom.hex + '@dummy.com'
		  	user.token = auth['credentials']['token']
		  	user.secret = auth['credentials']['secret']
        user.save!
				user
    end

  	def fitbit_data
	    @client ||= Fitgem::Client.new(
	                :consumer_key => "b2b615fe0ed44e74bfcd91f08d4dc1af",
	                :consumer_secret => "bce1d0a46dd74fda9a41071615ace73f",
	                :token => token,
	                :secret => secret,
	                :user_id => uid,
	                :ssl => true
	              )
  	end
    
end
