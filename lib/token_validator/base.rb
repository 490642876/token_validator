module TokenValidator

  class << self
    attr_accessor :test_mode
    attr_accessor :mock_value

    def validators
      @validators ||= {}
    end

    def mock_value
      @mock_value.nil? ? true : @mock_value
    end


    def add_validator provider, validator
      validators[provider] = validator
    end
  end

  class Base
    def validate uid, token
      raise "stub!"
    end
  end
end
