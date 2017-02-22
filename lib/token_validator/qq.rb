module TokenValidator
  class QQ
    def validate uid, token
      url = "https://graph.qq.com/oauth2.0/me?access_token=#{token}"
      metched = Faraday.get(url).body.match(/"openid":"(?<openid>\w+)"/)
      uid == metched[:openid] if metched
    end
  end

  add_validator(:qq, QQ.new)
end
