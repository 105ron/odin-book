class ApplicationMailer < ActionMailer::Base
  default :from => "Odin-Book <no-reply@odin-book.com>"
  layout 'mailer'
end
