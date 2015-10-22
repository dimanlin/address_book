class User < ActiveRecord::Base
  serialize :emails, Array
  serialize :phone_numbers, Array

  before_save :uniq_emails
  before_save :uniq_phone_numbers

  private

  def uniq_emails
    self.emails = (self.emails + emails).uniq
  end

  def uniq_phone_numbers
    self.emails = (self.emails + emails).uniq
  end
end
