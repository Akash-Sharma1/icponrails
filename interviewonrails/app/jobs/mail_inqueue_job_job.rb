class MailInqueueJobJob < ApplicationJob
  queue_as :default

  def perform(user, operation)
    puts user
    if (operation == "NEW")
        ScheduleMailer.with(user: user).NewScheduleMail.deliver_now
    elsif (operation == "DELETE")
        ScheduleMailer.with(user: user).DeleteScheduleMail.deliver_now
    elsif (operation == "REMIND")
        ScheduleMailer.with(user: user).ReminderScheduleMail.deliver_now   
    elsif (operation == "CHANGE")
        ScheduleMailer.with(user: user).ChangeScheduleMail.deliver_now
    end
  end
end
