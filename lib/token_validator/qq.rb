module TokenValidator
  class QQ
    def validate uid, token
      raise "Not implemented!"
    end
  end

  add_validator(:qq, QQ.new)
end
