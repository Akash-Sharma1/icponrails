class UsersController < ApplicationController
    def index
        @user = User.all
        respond_to do |format|
            format.json { render json: @user }
            format.js { render json: @user }
            format.html
        end
    end
    
    def show
        @user = User.find(params[:id])
        respond_to do |format|
            format.json { render json: @user }
            format.js { render json: @user }
            format.html
        end
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            respond_to do |format|
                format.json { render json: @user, status: :created }
                format.js { render json: @user, status: :created }
                format.html { redirect_to @user, notice: 'user was successfully scheduled.' }
            end
        else

            respond_to do |format|
                format.json { render json: @user.errors, status: :unprocessable_entity }
                format.js { render json: @user.errors, status: :unprocessable_entity }
                format.html { render :new }
            end
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            respond_to do |format|
                format.json { render json: @user }
                format.js { render json: @user, status: :ok }
                format.html { redirect_to @user, notice: 'user was successfully updated.' }
            end
        else
            respond_to do |format|
                format.js { render json: @user.errors, status: :unprocessable_entity }
                format.json { render json: @user.errors, status: :unprocessable_entity }
                format.html { render :edit }
            end
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        respond_to do |format|
            format.json { head :no_content }
            format.js { head :no_content }
            format.html { redirect_to users_path, notice: 'user was successfully destroyed.' }
        end
    end

    private
    def user_params
        params.require(:user).permit(:username, :email, :usertype, :resume)
    end
end
