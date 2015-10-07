class UsersController < ApplicationController

# 	layout 'admin'

# 	before_action :confirm_logged_in

#   def index
#   	@users = User.sorted
#   end

#   def new
#   	@user = User.new
#   end

#   def create
#   	@user = User.new(user_params)
#   	if @user.save
#       flash[:notice] = "User '#{@user.name}' created successfully"
#       redirect_to(:action => 'index')
#     else
#       render('new')
#     end
#   end

#   def edit
#   	@user = User.find(params[:id])
#   end

#   def update
#   	@user = User.find(params[:id])
#   	if @user.update_attributes(user_params)
#   		flash[:notice] = "User '#{@user.name}' updated successfully"
#   		redirect_to(:action => 'index')
#     else
#       render('edit')
#     end
#   end

#   def delete
#   	@user = User.find(params[:id])
#   end

#   def destroy
#   	user = User.find(params[:id]).destroy
#   	flash[:notice] = "User '#{user.name}' deleted successfully"
#   	redirect_to(:action => 'index')
#   end

#   private
#   def user_params
#   	params.require(:user).permit(:first_name, :last_name, :email, :password, :username)  	
#   end
end
