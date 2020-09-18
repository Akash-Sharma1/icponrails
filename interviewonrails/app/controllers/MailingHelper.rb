require 'json'

class MailingHelper

    def initialize()
        @CHANGE = "CHANGE"
        @NEW = "NEW"
        @DELETE = "DELETE"
        @REMIND = "REMIND"
        @startTime = ""
        @endTime = ""
        @prev_startTime = ""
        @prev_endTime = ""
        @prev_users = {}
        @interview_id = ""
    end

    def SetPrevInterview(prev_interview)
        @prev_users["users"] = prev_interview.users
        @prev_starTime = prev_interview.startTime.to_s
        @prev_endTime = prev_interview.endTime.to_s
    end

    def SendMail(operation, interview)
        return false if ( @prev_interview == {} && operation == @change )
        
        @startTime = interview.startTime.to_s
        @endTime = interview.endTime.to_s
        @interview_id = interview.id

        if operation != @CHANGE
            send_mail_by_user_array(interview.users, operation)
            return true
        end

        user_occurence = {}
        @prev_users["users"].each do |prev_user|
            puts prev_user.id
            user_occurence[prev_user] = @DELETE
        end
        interview.users.each do |new_user|
            if user_occurence[new_user] == @DELETE
                user_occurence[new_user] = @CHANGE
            else
                user_occurence[new_user] = @NEW
            end
        end

        new_users = []
        common_users = []
        deleted_users = []

        user_occurence.each do |key, value|
            if value == @NEW
                deleted_users.append(key)
            elsif value == @DELETE
                new_users.append(key)
            elsif value == @CHANGE
                common_users.append(key)
            end
        end

        send_mail_by_user_array(new_users, @NEW)
        send_mail_by_user_array(deleted_users, @DELETE)
        send_mail_by_user_array(common_users, @CHANGE)
        
        if(operation == @NEW || operation == @CHANGE)
            MailInqueueJobJob.set(wait_until: @endTime.to_datetime - 5.hours - 30.minutes).perform_later(@interview_id, @endTime)
        end

        return true
    end

    private 
    def send_mail_by_user_array(users, operation)
        users.each do |user|
            send_mail(user, operation)
        end
    end

    private
    def send_mail(user, operation)
        puts user.id
        if (operation == @NEW)
            ScheduleMailer.with(user: user, startTime: @startTime, endTime: @endTime).NewScheduleMail.deliver_later
            ScheduleMailer.with(user: user, startTime: @startTime, endTime: @endTime).ReminderScheduleMail.deliver_later!(wait_until: @startTime.to_datetime - 5.hours - 30.minutes) 
        elsif (operation == @DELETE)
            ScheduleMailer.with(user: user, startTime: @startTime, endTime: @endTime).DeleteScheduleMail.deliver_later
        elsif (operation == @REMIND)
            ScheduleMailer.with(user: user, startTime: @startTime, endTime: @endTime).ReminderScheduleMail.deliver_later
        elsif (operation == @CHANGE)
            ScheduleMailer.with(user: user, startTime: @startTime, endTime: @endTime, prev_startTime: @startTime, prev_endTime: @prev_endTime).ChangeScheduleMail.deliver_later
            ScheduleMailer.with(user: user, startTime: @startTime, endTime: @endTime).ReminderScheduleMail.deliver_later!(wait_until: @startTime.to_datetime - 5.hours - 30.minutes) 
        end
    end
end
