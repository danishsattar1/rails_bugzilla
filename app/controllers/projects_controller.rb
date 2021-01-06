class ProjectsController < ApplicationController
	load_and_authorize_resource
	before_action :find_project, only: [:show, :edit, :update, :destroy, :createMember]
	def index
		@projects = current_user.projects
	end
	def new
		@project = current_user.projects.new
	end

	def create
		@project = current_user.projects.new(project_params)	
		respond_to do |format|
			if @project.save
				format.html { redirect_to projects_path, notice: 'Project Created.' }
			else
				format.html { render :new }
			end
		end
	end

	def show
		@added_members = @project.users
		@addMember = @project.user_project.new
		@usersToShow = User.where.not(id: @added_members.ids).notManager
	end

	def edit
	end
	def update
		respond_to do |format|
		  if @project.update(project_params)
		    format.html { redirect_to projects_path, notice: 'Project was successfully updated.' }
		  else
		    format.html { render :edit }
		  end
		end
	end
	def destroy
		@project.destroy
		respond_to do |format|
	      format.html { redirect_to projects_path, notice: 'Project was successfully deleted.' }
	    end
	end
	def createMember
		@addMember = @project.user_project.new(params.require(:user_project).permit(:user_id))
		respond_to do |format|
			if @addMember.save
				format.html {redirect_to project_path(@project), notice: 'Member was successfully added' }
			else
				format.html {redirect_to project_path(@project), alert: 'Please select an member' }
			end
		end
	end

	private
	def find_project
		@project=Project.find(params[:id])
	end
	def project_params
		params.require(:project).permit(:title,:description)
	end
end
