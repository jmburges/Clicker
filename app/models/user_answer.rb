class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :answer

  after_save :push_answered

  private
  def push_answered
    message = "updated"
    faye = Faye::Client.new("http://localhost:9292/faye")

faye.add_extension(ClientAuth.new)
    faye.publish('/charts/new_answer',message)
  end
end

class ClientAuth
  def outgoing(message, callback)
    # Add ext field if it's not present
    message['ext'] ||= {}

    # Set the auth token
    message['ext']['auth_token'] = FAYE_TOKEN

    # Carry on and send the message to the server
    callback.call(message)
  end
end
