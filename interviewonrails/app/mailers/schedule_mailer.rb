class ScheduleMailer < ApplicationMailer
    default from: 'from@example.com'
    
    before_action :getdetails, only: [:NewScheduleMail, :DeleteScheduleMail, :ReminderScheduleMail, :ChangeScheduleMail]


    def NewScheduleMail
        puts mail(to: @user.email, subject: 'New Interview Scheduled') 
    end

    def DeleteScheduleMail
        puts mail(to: @user.email, subject: 'Cancellation of Scheduled Interview') 
    end

    def ReminderScheduleMail
        puts mail(to: @user.email, subject: 'Reminder for Scheduled Interview') 
    end
    
    def ChangeScheduleMail
        @prev_startTime = params[:prev_startTime]
        @prev_endTime = params[:prev_endTime]
        puts mail(to: @user.email, subject: 'Change in Scheduled Interview') 
    end

    private
    def getdetails
        @user = params[:user]
        @startTime = params[:startTime]
        @endTime = params[:endTime]
    end

end
