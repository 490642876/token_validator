module TokenValidator
  class Google
    GOOGLE_PEM_URL = "https://www.googleapis.com/oauth2/v1/certs"

    def validate uid, token
      begin
        header_segment = JSON.parse(Base64.decode64(token.split(".").first))
        alg = header_segment["alg"]
        kid = header_segment["kid"]
        google_response = Faraday.get(GOOGLE_PEM_URL).body
        google_certificate = JSON.parse(google_response)
        certificate = OpenSSL::X509::Certificate.new(google_certificate[kid])
        token_data = JWT.decode(token, certificate.public_key, true, {:algorithm => alg})[0]
        uid == token_data["sub"]
      rescue StandardError => e
        false
      end
    end
  end

  add_validator(:google, Google.new)
end
