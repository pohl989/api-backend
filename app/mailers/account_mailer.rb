class AccountMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  # including devise helpers means that we have access to all the features for devise 
  # and now we control every aspect of devise notifications, invitation, password
  #confirmation , etc.
  include Devise::Controllers::UrlHelpers 
  default template_path: 'devise/mailer' 
  layout 'mailer'


  def invitation_instructions(record, token, opts={})
    @token = token
    devise_mail(record, record.invitation_instructions || :invitation_instructions, opts)
  end

end
