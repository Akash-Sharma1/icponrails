require 'MailingHelper'

class InterviewsController < ApplicationController

    before_action :getinterview, only: [:show, :remind, :edit, :update, :destroy]

    def index
        @interview = Interview.all
        @users = User.all
    end
    
    def show
    end

    def remind
        helper = MailingHelper.new
        helper.SendMail("REMIND",@interview)
        redirect_to interviews_path
    end

    def new
        @users = User.all
        @interview = Interview.new
    end
    
    def edit
        @users = User.all
    end

    def create
        @users = User.all
        @interview = Interview.new(interview_params)
        @interview.user_ids = params[:user_ids]
        if @interview.save
            helper = MailingHelper.new
            helper.SendMail("NEW",@interview)
            redirect_to @interview
        else
            render 'new'
        end
    end
    
    def update
        @users = User.all
        @interview.user_ids = params[:user_ids]
        helper = MailingHelper.new
        helper.SetPrevInterview(@interview)
            
        if @interview.update(interview_params)
            helper.SendMail("CHANGE", @interview)
            redirect_to @interview
        else
            render 'edit'
        end
    end

    def destroy
        helper = MailingHelper.new
        helper.SendMail("DELETE", @interview)
        @interview.destroy
        redirect_to interviews_path
    end

    private
    def interview_params
        params.require(:interview).permit(:startTime, :endTime, user_ids: [])
    end

    private
    def getinterview
        @interview = Interview.find(params[:id])
    end
end



