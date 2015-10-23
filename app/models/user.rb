class User < ActiveRecord::Base
  serialize :emails, Array
  serialize :phone_numbers, Array

  before_save :uniq_emails
  before_save :uniq_phone_numbers

  before_validation :remove_empty_values!

  validates :first_name, :last_name, :emails, :phone_numbers, presence: true
  validate :validate_full_name

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def remove_empty_values!
    [emails, phone_numbers].each do |field|
      field.delete_if {|z| z.length == 0}
    end
  end

  def validate_full_name
    if changed.include?('last_name') || changed.include?('first_name')
      user = User.where({last_name: last_name, first_name: first_name}).first
      if user
        errors.add(:full_name, 'Sorry but you already have that user')
      end
    end
  end

  def uniq_emails
    self.emails = emails.uniq
  end

  def uniq_phone_numbers
    self.phone_numbers = phone_numbers.uniq
  end
end
