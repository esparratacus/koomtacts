module ApiAuthorization
  class TokenManager
    class TokenEncodingError < StandardError; end

    def self.encode_token(payload)
      raise TokenEncodingError if payload.nil?

      JWT.encode(payload, Rails.application.secret_key_base)
    end
  end
end
