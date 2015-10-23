class User < ActiveRecord::Base
  serialize :emails, Array
  serialize :phone_numbers, Array

  before_save :uniq_emails
  before_save :uniq_phone_numbers
  before_save :clear_phone_numbers

  before_validation :remove_empty_values!

  validates :first_name, :last_name, presence: true
  validate :validate_full_name
  validates :emails, presence: true, if: Proc.new { |user| !user.phone_numbers.present? }
  validates :phone_numbers, presence: true, if: Proc.new { |user| !user.emails.present? }

  def self.import(file)
    spreadsheet = Roo::Spreadsheet.open(file)
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[header, spreadsheet.row(i)].transpose]
      user = find_by_id(row["id"]) || new
      user.first_name = row['first_name']
      user.last_name = row['last_name']
      user.phone_numbers = JSON.parse(row['phone_numbers'])
      user.emails = JSON.parse(row['emails'])
      user.save!
    end
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  private

  def clear_phone_numbers
    phone_numbers.collect! {|number| number.gsub('(', '').gsub(')', '').gsub('-', '').gsub('+', '')}
  end

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
