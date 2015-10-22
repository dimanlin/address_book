class User < ActiveRecord::Base
  serialize :emails, Array
  serialize :phone_numbers, Array
end
