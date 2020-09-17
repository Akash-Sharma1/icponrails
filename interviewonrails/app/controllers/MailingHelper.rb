require 'json'

class MailingHelper
    def SendMail(interview, operation)
        user1 = User.find(interview.participant1_id)
        user2 = User.find(interview.participant2_id)
        send_mail(user1 , operation, interview)
        send_mail(user2 , operation, interview)
    end

    def SendAccrodingly(prev_user1, prev_user2, new_interview)
        prev_user1 = User.find(prev_user1)
        prev_user2 = User.find(prev_user2)
        new_user1 = User.find(new_interview.participant1_id)
        new_user2 = User.find(new_interview.participant2_id)

        if (prev_user1 != new_user1 && prev_user1 != new_user2)
            send_mail(prev_user1, "DELETE", interview)
        end
        if (prev_user2 != new_user1 && prev_user2 != new_user2)
            send_mail(prev_user2, "DELETE", interview)
        end
        
        if (prev_user1 != new_user1 && prev_user2 != new_user1)
            send_mail(new_user1, "NEW", interview)
        end
        if (prev_user1 != new_user2 && prev_user2 != new_user2)
            send_mail(new_user2, "NEW", interview)
        end
        
        if (prev_user1 == new_user1 || prev_user1 == new_user2)
            send_mail(prev_user1, "CHANGE", interview)
        end
        if (prev_user2 == new_user1 || prev_user2 == new_user2)
            send_mail(prev_user2, "CHANGE", interview)
        end
    end

    private
    def send_mail(user, operation, interview)
        if (operation == "NEW")
            ScheduleMailer.with(user: user).NewScheduleMail.deliver_later
            ScheduleMailer.with(user: user).NewScheduleMail.deliver_later!(wait_until: interview.startTime - 5.hours - 30.minutes) 
        elsif (operation == "DELETE")
            ScheduleMailer.with(user: user).DeleteScheduleMail.deliver_later
        elsif (operation == "REMIND")
            ScheduleMailer.with(user: user).ReminderScheduleMail.deliver_later   
        elsif (operation == "CHANGE")
            ScheduleMailer.with(user: user).ChangeScheduleMail.deliver_later
        end
    end
end

``