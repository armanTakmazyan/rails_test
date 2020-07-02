class CompaniesController < ApplicationController
    before_action :require_signin
    before_action :require_admin

    def index
        @companies = Company.all.order('created_at DESC')
    end
end
