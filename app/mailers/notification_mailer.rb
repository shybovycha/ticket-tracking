class NotificationMailer < ActionMailer::Base
  default :from => "from@example.com"

  def ticket_submit_email(ticket)
    @ticket = ticket

    mail(:to => @ticket.reporter_email, :subject => "Your issue has been submit!")
  end

  def ticket_comment_email(comment)
    @comment = comment
    @ticket = @comment.ticket

    mail(:to => @ticket.reporter_email, :subject => "A reply has been posted on your issue")
  end
end
