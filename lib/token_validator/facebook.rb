module TokenValidator
  class Facebook
    def validate uid, token
      url = "https://graph.facebook.com/debug_token?input_token=#{token}&access_token=#{ENV["FACEBOOK_APP_ID"]}|#{ENV["FACEBOOK_APP_SECRET"]}"
      facebook_response = MultiJson.load(Faraday.get(url).body)
      facebook_response["data"]["is_valid"] && facebook_response["data"]["user_id"].to_s == uid
    end
  end

  add_validator(:facebook, Facebook.new)
end
