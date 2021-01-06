class BugsController < ApplicationController
	load_and_authorize_resource param_method: :bugs_params
	before_action :find_bug, only: [:show, :edit, :update, :destroy, :changeStatus]
	before_action :find_developers, only: [:new, :create, :edit, :update]

	def index
	    @project=Project.find(params[:project_id])
	    if current_user.usertype == "Developer"
	    @bugs = @project.bugs.where(developer_id: current_user.id)
	    else 
	    @bugs = @project.bugs
		end
	end
	def new
		@bug = @project.bugs.new
	end
	def create
		
		@bug = @project.bugs.new(bugs_params)
		respond_to do |format|
			if @bug.save
				format.html { redirect_to project_bugs_path(@project), notice: 'Bug was successfully Created.' }
			else
				format.html { render :new }
			end
		end
	end	
	def show
	end
	def edit
	end
	def update
		respond_to do |format|
		  if @bug.update(bugs_params)
		    format.html { redirect_to project_bugs_path(@project), notice: 'Bug was successfully updated.' }
		  else
		    format.html { render :edit }
		  end
		end
	end
	def destroy
		@bug.destroy
		respond_to do |format|
	      format.html { redirect_to project_bugs_path(@project), notice: 'Bug was successfully deleted.' }
	    end
	end
	def changeStatus
		respond_to do |format|
		  if @bug.update(status: params[:bug][:status])
		    format.html { redirect_to project_bugs_path(@project), notice: 'Status was successfully updated.' }
		  else
		    format.html { render :show }
		  end
		end
	end
	private
	def find_developers
		@project=Project.find(params[:project_id])
		@developers = @project.users.developers
	end
	def find_bug
		@project=Project.find(params[:project_id])
		@bug = Bug.find(params[:id])
	end
	def bugs_params
		params.require(:bug).permit(:title, :description, :deadline, :bugtype, :developer_id, :screenshot).merge(:user_id => current_user.id)
	end
end
