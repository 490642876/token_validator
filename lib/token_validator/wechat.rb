module TokenValidator
  class Wechat
    def validate uid, token
      url = "https://api.weixin.qq.com/sns/auth?access_token=#{token}&openid=#{uid}"
      MultiJson.load(Faraday.get(url).body)['errcode'] == 0
    end
  end

  add_validator(:wechat, Wechat.new)
end
