require 'jwt'
module TokenValidator
  class Apple
    APPLE_PEM_URL = "https://appleid.apple.com/auth/keys"

    def validate uid, token
      begin
        header_segment = JSON.parse(Base64.decode64(token.split(".").first))
        alg = header_segment["alg"]
        kid = header_segment["kid"]
        apple_response = Faraday.get(APPLE_PEM_URL).body
        apple_certificate = JSON.parse(apple_response)
        apple_key = apple_certificate["keys"].find {|h| h["kid"] == kid}
        apple_key = apple_key.inject({}) {|h, (k, v)| h[k.to_sym] = v; h}
        jwk = JWT::JWK.import(apple_key)
        token_data = JWT.decode(token, jwk.public_key, true, {algorithm: alg})[0]
        uid == token_data["sub"]
      rescue StandardError => e
        false
      end
    end
  end

  add_validator(:apple, Apple.new)
end
