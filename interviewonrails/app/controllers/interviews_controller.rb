require 'MailingHelper'

class InterviewsController < ApplicationController

    before_action :getusers, only: [:new, :edit, :create, :update]
    before_action :getinterview, only: [:show, :remind, :edit, :update, :destroy]

    def index
        @interview = Interview.all
        @user = User.all
    end
    
    def show
    end

    def remind
        helper = MailingHelper.new
        helper.SendMail(@interview, "REMIND")
        redirect_to interviews_path
    end

    def new
        @interview = Interview.new
    end
    
    def edit
    end

    def create
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
        helper = MailingHelper.new 
        helper.SendMail(@interview, "DELETE")
        @interview.destroy
        redirect_to interviews_path
    end

    private
    def interview_params
        params.require(:interview).permit(:startTime, :endTime, :participant1_id, :participant2_id)
    end
    
    private
    def getusers
        @userparticipant = User.where("usertype = :usertype" , {usertype: "participant"})
        @useradmin = User.where("usertype = :usertype" , {usertype: "admin"})
    end

    private
    def getinterview
        @interview = Interview.find(params[:id])
    end
end



