class ApplicationMailer < ActionMailer::Base
  default from: "notifications@pmtool.com"
  layout 'mailer'
end
