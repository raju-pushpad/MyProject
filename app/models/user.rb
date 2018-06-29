class User < ApplicationRecord
  rolify
  validates :name , :contact , presence: true
  validates :name , length: {minimum: 5}
  validates :contact, length: {is: 10, message: "Must be 10 digit"}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
          :confirmable, :lockable,
           :omniauthable, :omniauth_providers => [:facebook, :google_oauth2, :linkedin, :twitter]
  has_many :posts
  

def self.new_with_session(params, session)
  super.tap do |user|
    if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
      user.email = data["email"] if user.email.blank?
    end
  end
end

def self.from_omniauth(auth)

  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
     
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]
    user.uid = auth.uid
    user.name = auth.info.name   # assuming the user model has a name
    user.image = auth.info.image # assuming the user model has an image
    user.contact = 1478523690
    user.add_role :reader
    user.save!
  end
end


def self.find_or_create_from_auth_hash(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.first_name+auth.info.last_name
      user.email = auth.info.email
      user.image = auth.info.image
      user.contact = 1478523690
    user.add_role :reader
      user.save!
    end
  end


  def self.connect_to_linkedin(auth, signed_in_resource=nil) 
   
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.first_name+auth.info.last_name
      user.email = auth.info.email
      user.image = auth.info.image
      user.contact = 1478523690
      user.password = Devise.friendly_token[0,20]
    user.add_role :reader
      user.save!
    end
  end

def self.from_omniauth_twitter(auth)
  # byebug
  where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.nickname+"@mytask.com"
      user.image = auth.info.image
      user.contact = 1478523690
      user.password = Devise.friendly_token[0,20]
    user.add_role :reader
      user.save!
    end
end

end
