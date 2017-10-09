class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.persisted?
      sign_in_and_redirect user, notice: 'Signed in!'
    else
      redirect_to new_user_session_url
    end
  end
end
