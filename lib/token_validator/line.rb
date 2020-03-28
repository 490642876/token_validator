module TokenValidator
  class Line
    def validate uid, token
      res = false
      url = "https://api.line.me/oauth2/v2.1/verify?access_token=#{token}"
      resp = MultiJson.load(Faraday.get(url).body)
      if resp["expires_in"] > 0 && resp['client_id'].to_s == ENV["LINE_APP_ID"]
        profile_url = "https://api.line.me/v2/profile"
        profile_resp = Faraday.get(profile_url) do |req|
          req.headers['Authorization'] = "Bearer #{token}"
        end
        res = MultiJson.load(profile_resp.body)['userId'].to_s == uid
      end
      res
    end
  end

  add_validator(:line, Line.new)
end
