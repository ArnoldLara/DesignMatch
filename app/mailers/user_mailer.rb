require 'aws-sdk'

class UserMailer < ApplicationMailer

  def notification_design(email, user)
    @sender = 'DesignMatch007@gmail.com'
    @subject = 'Your design has been processed!'
    @text_body = "<p>Hi <strong>#{user}</strong>, your design has been processed</p><br><p>Come see it in #{ENV['base_url']}</p>"
    @encoding = 'UTF-8'
    ses = Aws::SES::Client.new(region: 'us-east-1',
                               access_key_id: ENV['KEY_OSCAR'],
                               secret_access_key: ENV['SECRET_OSCAR'])
    begin
       ses.send_email( destination: { to_addresses: [email] },
            message: {
                body: { html: { charset: @encoding, data: @text_body }, text: {charset: @encoding, data: @text_body } },
                subject: { charset: @encoding, data: @subject }
            },
            source: @sender
       )
    rescue Aws::SES::Errors::ServiceError => error
        puts "Email not sent. Error message: #{error}"
    end
  end
end
