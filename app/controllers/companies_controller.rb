class CompaniesController < ApplicationController
    before_action :require_signin
    before_action :require_admin

    def index
        @companies = Company.all.order('created_at DESC')
    end

    def new
        @company = Company.new
    end

    def create
        @company = Company.new(resume_params)
        
        if @company.save
            flash.notice = "The company #{@company.name} has been uploaded."
            redirect_to companies_path
        else
            render :new  
        end
    end

    def show
         @company = Company.find(params[:id])
    end

    def edit
        @company = Company.find(params[:id]) 
    end

    def update
        @company = Company.find_by(id: params[:id])
        if @company.update(resume_params)
            redirect_to @company, notice: "Company successfully updated!"
        else
            render :edit
        end
    end

    def destroy
        name = Company.find(params[:id]).name 
        Company.find(params[:id]).destroy
        redirect_to companies_path, notice: "#{name} deleted." 
    end

private 

    def resume_params
        params.require(:company).permit(:name, :email, :website, :logo)
    end
end
