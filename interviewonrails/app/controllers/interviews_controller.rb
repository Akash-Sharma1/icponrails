class InterviewsController < ApplicationController
    def index
        @interview = Interview.all
    end
    
    def show
        @interview = Interview.find(params[:id])
    end

    def new
        @interview = Interview.new
    end
    
    def edit
        @interview = Interview.find(params[:id])
    end

    def create
        @user = User.find(params[:id])
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
        params.require(:interview).permit(:startTime, :endTime)
    end
end
