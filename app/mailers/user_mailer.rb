class UserMailer < ApplicationMailer
  default from: "owner@address_book.com"

  def shared(email, user)
    @user = user
    mail(to: email, subject: 'Shared email')
  end
end
