class TeamsController < ApplicationController
  
  before_action :logged_in_user
  
  layout 'sidebar'
  
  def index
    @teams = Team.search(params[:search], :name).sort(params[:sort], params[:direction]).paginate(page: params[:page])
  end
  
  def show
    @teams = Team.find(params[:id])
  end
  
  def new
    @teams = Team.new
  end
  
  def edit
    @teams = Team.find(params[:id])
  end
  
  def create
    @teams = Team.new(user_params)
    if @teams.save
      flash[:success] = t('.flash.success.message')
      redirect_to @teams
    else
      render 'new'
    end
  end
  
  def update
    @teams = Team.find params[:id]
    if @teams.update_attributes team_params
      flash[:success] = t('.flash.success.message')
      redirect_to @teams
    else
      render 'edit'
    end
  end
  
  def destroy
    @teams = Team.find params[:id]
    if @teams.destroy
      flash[:success] = t('.flash.success.message')
      redirect_to teams_path
    end
  end
end
