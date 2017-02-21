module TokenValidator
  class Wechat
    def validate uid, token
      raise "Not implemented!"
    end
  end

  add_validator(:wechat, Wechat.new)
end
