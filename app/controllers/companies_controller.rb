class CompaniesController < ApplicationController
  before_action :logged_in_user
  
  layout 'sidebar'
  
  def index
    @companies = Company.search(params[:search], :name).sort(params[:sort], params[:direction]).paginate(page: params[:page])
  end
  
  def show
    @company = Company.find(params[:id])
  end
  
  def new
    @company = Company.new
  end
  
  def edit
    @company = Company.find(params[:id])
  end
  
  def create
    @company = Company.new(company_params)
    if @company.save
      flash[:success] = t('.flash.success.message')
      redirect_to @company
    else
      render 'new'
    end
  end
  
  def update
    @company = Company.find(params[:id])
    if @company.update_attributes(company_params)
      flash[:success] = t('.flash.success.message')
      redirect_to @company
    else
      render 'edit'
    end
  end
  
  def destroy
    @company = Company.find(params[:id])
    if @company.destroy
      flash[:success] = t('.flash.success.message')
      redirect_to companies_path
    end
  end
  
  private

  def company_params
    params.require(:company).permit(:name)
  end
end
