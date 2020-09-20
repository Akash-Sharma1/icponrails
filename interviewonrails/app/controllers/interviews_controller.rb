require 'MailingHelper'

class InterviewsController < ApplicationController
    skip_before_action  :verify_authenticity_token  
    before_action :getinterview, only: [:show, :remind, :edit, :update, :destroy]

    def index
        @interview = Interview.all
        @users = User.all

        respond_to do |format|
            format.json { render json: @interview }
            format.js { render json: @interview }
            format.html
        end
    end
    
    def show
        respond_to do |format|
            format.json { render json: @interview }
            format.js { render json: @interview }
            format.html
        end
    end

    def remind
        helper = MailingHelper.new
        helper.SendMail("REMIND",@interview)
        
        respond_to do |format|
            format.json { render json: @interview }
            format.js { render json: @interview }
            format.html { render 'index' }
        end
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

            respond_to do |format|
                format.json { render json: @interview, status: :created }
                format.js { render json: @interview, status: :created }
                format.html { redirect_to @interview, notice: 'Interview was successfully scheduled.' }
            end
        else

            respond_to do |format|
                format.json { render json: @interview.errors, status: :unprocessable_entity }
                format.js { render json: @interview.errors, status: :unprocessable_entity }
                format.html { render :new }
            end
        end
    end
    
    def update
        @users = User.all
        @interview.user_ids = params[:user_ids]
        helper = MailingHelper.new
        helper.SetPrevInterview(@interview)
            
        if @interview.update(interview_params)
            helper.SendMail("CHANGE", @interview)
            respond_to do |format|
                format.json { render json: @interview }
                format.js { render json: @interview, status: :ok }
                format.html { redirect_to @interview, notice: 'Interview was successfully updated.' }
            end
        else
            respond_to do |format|
                format.js { render json: @interview.errors, status: :unprocessable_entity }
                format.json { render json: @interview.errors, status: :unprocessable_entity }
                format.html { render :edit }
            end
        end
    end

    def destroy
        helper = MailingHelper.new
        helper.SendMail("DELETE", @interview)
        @interview.destroy
        respond_to do |format|
            format.json { head :no_content }
            format.js { head :no_content }
            format.html { redirect_to interviews_path, notice: 'interview was successfully destroyed.' }
        end
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



