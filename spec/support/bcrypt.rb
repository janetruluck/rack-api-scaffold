require 'bcrypt'
module BCrypt
  class Engine
    Kernel.silence_warnings do
      DEFAULT_COST = 1
    end
  end
end