class InterviewsController < ApplicationController
    def index
        @interview = Interview.all
        @user = User.all
    end
    
    def show
        @interview = Interview.find(params[:id])
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
        @interview = Interview.create(interview_params)
        @interview.save
        redirect_to @interview
    end
    
    def update
        @interview = Interview.find(params[:id])
        @interview.update(interview_params)
        redirect_to @interview
    end

    def destroy
        @interview = Interview.find(params[:id])
        @interview.destroy
        redirect_to interviews_path
    end

    private
    def interview_params
        params.require(:interview).permit(:startTime, :endTime, :participant1_id, :participant2_id)
    end
end
