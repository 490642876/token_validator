module TokenValidator
  class Weibo
    def validate uid, token
      url = "https://api.weibo.com/oauth2/get_token_info"
      MultiJson.load(Faraday.post(url, access_token: token).body)['uid'].to_s == uid
    end
  end

  add_validator(:weibo, Weibo.new)
end
