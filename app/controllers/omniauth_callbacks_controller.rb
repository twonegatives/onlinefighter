class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    auth = request.env['omniauth.auth']

    error = Proc.new do
              flash.alert = 'Error while authenticating'
              redirect_to root_path
              return
            end

    error.call unless auth
    name, uid, email, provider =  [auth.info.nickname, auth.uid, auth.info.email, auth.provider]
    error.call if uid.blank? && provider.blank?
    auth = Service.where(:uid => uid, :provider => provider).first

    if current_user
      if auth
        flash.notice = provider + ' is already linked to your account'
      else
        current_user.services.create!(:provider => provider, :uid => uid, :uname => name, :uemail => email)
        flash.notice = 'Sign in via ' + provider + ' has been added to your account'
      end
      redirect_to root_path
    else
      if auth
        flash.notice = 'Signed in successfully via ' + provider
        sign_in_and_redirect auth.user, :event => :authentication
      else
        if email.blank?
          binding.pry
          flash.alert = 'Sign in via ' + provider + ' can not be used to sign up as no valid email address provided. Please sign in with another social network and bind your ' + provider + ' account to it.'
          redirect_to root_path
        else
          existing_user = User.where(:email => email).first
          if existing_user
            existing_user.services.create!(:provider => provider, :uid => uid, :uname => name, :uemail => email)
            flash.notice = 'Sign in via ' + provider + ' has been added to your account'
            sign_in_and_redirect existing_user, :event => :authentication
          else
            name = name[0,39]
            @user = User.new :email => email, :username => name, :password => SecureRandom.hex(10)
            @user.services.build(:provider => provider, :uid => uid, :uname => name, :uemail => email)
            if @user.save
              flash.notice = 'Accout created via ' + provider
              sign_in_and_redirect @user, :event => :authentication
            else
              session["devise.user_attributes"] = @user.attributes
              flash.notice = 'Auth failed'
              redirect_to root_path
            end
          end
        end
      end
    end
  end

  alias_method :twitter, :all
  alias_method :facebook, :all
  alias_method :vkontakte, :all
end
