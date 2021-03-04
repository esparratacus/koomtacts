module Api::V1
  class UsersController < ApiController
    def sign_in
      @user = User.find_by!(email:params[:email])
      if @user.valid_password?(params[:password])
        render json: { token: ApiAuthorization::TokenManager.encode_token({ user_id: @user.id} ) }
      else
        render json: {}, status: :unauthorized
      end
    end
  end
end