require 'MailingHelper'

class InterviewsController < ApplicationController
    def index
        @interview = Interview.all
        @user = User.all
    end
    
    def show
        @interview = Interview.find(params[:id])
        helper = MailingHelper.new
        helper.SendMail(@interview, "REMIND")
    end

    def new
        @user = User.all
        @interview = Interview.new
    end
    
    def edit
        @user = User.all
        @interview = Interview.find(params[:id])
    end

    def create
        @user = User.all
        @interview = Interview.new(interview_params)
        if @interview.save
            helper = MailingHelper.new
            helper.SendMail(@interview, "NEW")
            redirect_to @interview
        else
            render 'new'
        end
    end
    
    def update
        @interview = Interview.find(params[:id])
        prev_user1 = @interview.participant1_id
        prev_user2 = @interview.participant2_id

        if @interview.update(interview_params)
            helper = MailingHelper.new
            helper.SendAccrodingly(prev_user1, prev_user2, @interview)
            
            redirect_to @interview
        else
            render 'edit'
        end
    end

    def destroy
        @interview = Interview.find(params[:id])        
        helper = MailingHelper.new 
        helper.SendMail(@interview, "DELETE")
        @interview.destroy
        redirect_to interviews_path
    end

    private
    def interview_params
        params.require(:interview).permit(:startTime, :endTime, :participant1_id, :participant2_id)
    end
end



