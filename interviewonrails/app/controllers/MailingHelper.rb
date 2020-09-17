require 'json'

class MailingHelper
    def SendMail(interview, operation)
        user1 = User.find(interview.participant1_id)
        user2 = User.find(interview.participant2_id)
        send_mail(user1 , operation)
        send_mail(user2 , operation)
    end

    def SendAccrodingly(prev_user1, prev_user2, new_interview)
        prev_user1 = User.find(prev_user1)
        prev_user2 = User.find(prev_user2)
        new_user1 = User.find(new_interview.participant1_id)
        new_user2 = User.find(new_interview.participant2_id)

        if (prev_user1 != new_user1 && prev_user1 != new_user2)
            send_mail(prev_user1, "DELETE")
        end
        if (prev_user2 != new_user1 && prev_user2 != new_user2)
            send_mail(prev_user2, "DELETE")
        end
        
        if (prev_user1 != new_user1 && prev_user2 != new_user1)
            send_mail(new_user1, "NEW")
        end
        if (prev_user1 != new_user2 && prev_user2 != new_user2)
            send_mail(new_user2, "NEW")
        end
        
        if (prev_user1 == new_user1 || prev_user1 == new_user2)
            send_mail(prev_user1, "CHANGE")
        end
        if (prev_user2 == new_user1 || prev_user2 == new_user2)
            send_mail(prev_user2, "CHANGE")
        end
    end

    private
    def send_mail(user, operation)
        MailInqueueJobJob.perform_later(user, operation)
    end
end
