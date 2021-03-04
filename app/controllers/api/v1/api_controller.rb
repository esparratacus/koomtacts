module Api::V1
  class ApiController < ActionController::API
    attr_reader :current_user

    include JsonapiErrorsHandler
    ErrorMapper.map_errors!({
                              'ActiveRecord::RecordNotFound' => 'JsonapiErrorsHandler::Errors::NotFound'
                            })
    rescue_from ::StandardError, with: lambda { |e| handle_error(e) }

    rescue_from ActiveRecord::RecordInvalid, with: lambda { |e| handle_validation_error(e) }
    rescue_from ActiveModel::ValidationError, with: lambda { |e| handle_validation_error(e) }

    def handle_validation_error(error)
      error_model = error.try(:model) || error.try(:record)
      mapped = JsonapiErrorsHandler::Errors::Invalid.new(errors: error_model.errors)
      render_error(mapped)
    end

    def auth_header
      request.headers['Authorization']
    end
    def logged_in_user
      if auth_header
        decoded_token = ApiAuthorization::TokenManager.decoded_token(auth_header.split(' ')[1])
        @current_user = User.find_by(id: decoded_token['user_id'])
      end
    end

    def is_logged_in?
      !!logged_in_user
    end

    def authorized
      render json:{message: 'Please login'}, status: :unauthorized unless is_logged_in?
    end
  end
end
