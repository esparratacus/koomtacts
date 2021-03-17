class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def github

    @user = User.find_or_register_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user.contacts
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      flash[:error] = 'Problem signing in using github'
      redirect_to new_user_registration_url
    end
  end
end
