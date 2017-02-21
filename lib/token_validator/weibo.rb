module TokenValidator
  class Weibo
    def validate uid, token
      raise "Not implemented!"
    end
  end

  add_validator(:weibo, Weibo.new)
end
