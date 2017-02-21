require "token_validator/base"
require "token_validator/qq"
require "token_validator/wechat"
require "token_validator/weibo"

require "token_validator/version"

module TokenValidator

  def self.validate provider, uid, token
    validators[provider.to_sym].validate(uid, token)
  end

end
