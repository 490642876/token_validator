module TokenValidator
  @@validators = {}

  def self.validators
    @@validators
  end

  def self.add_validator provider, validator
    validators[provider] = validator
  end

  class Base
    def validate uid, token
      raise "stub!"
    end
  end
end
