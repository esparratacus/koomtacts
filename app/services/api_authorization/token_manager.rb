module ApiAuthorization
  class TokenManager
    class TokenEncodingError < StandardError; end

    class TokenDecodingError < StandardError; end

    KEY = Rails.application.secret_key_base

    def self.encode_token(payload)
      raise TokenEncodingError if payload.nil?

      JWT.encode(payload, KEY)
    end

    def self.decoded_token(token)
      JWT.decode(token, KEY, true, algorithm: 'HS256')[0]
    rescue JWT::DecodeError
      raise TokenDecodingError
    end
  end
end
