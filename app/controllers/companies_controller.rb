class CompaniesController < ApplicationController
    before_action :require_signin
    before_action :require_admin
    around_action :catch_not_found

    def index
        @companies = Company.paginate(page: params[:page], per_page: 1).order('created_at DESC')
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
        current_company = Company.find(params[:id])
        name = current_company.name 
        id = current_company.id
        current_company.destroy
        FileUtils.remove_dir("#{Rails.root}/public/uploads/company/logo/#{id}", :force => true)
        redirect_to companies_path, notice: "#{name} deleted." 
    end

private 

    def resume_params
        params.require(:company).permit(:name, :email, :website, :logo)
    end

    def catch_not_found
        yield
        rescue ActiveRecord::RecordNotFound
            redirect_to root_path, :flash => { :error => "Record not found." }
    end
end
