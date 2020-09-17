class ScheduleMailer < ApplicationMailer
    default from: 'from@example.com'

    def NewScheduleMail
        @user = params[:user]
        puts mail(to: @user.email, subject: 'New Interview Scheduled') 
    end

    def DeleteScheduleMail
        @user = params[:user]
        puts mail(to: @user.email, subject: 'Cancellation of Scheduled Interview') 
    end

    def ReminderScheduleMail
        @user = params[:user]
        puts mail(to: @user.email, subject: 'Reminder for Scheduled Interview') 
    end
    
    def ChangeScheduleMail
        @user = params[:user]
        puts mail(to: @user.email, subject: 'Change in Scheduled Interview') 
    end
end
