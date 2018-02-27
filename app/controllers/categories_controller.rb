class CategoriesController < ApplicationController
  before_action :find_category , only: [:update, :destroy]
  def index
    @categories = Category.order(created_at: :desc)
  end
  def show
    
  end

  def new
    
  end

  def create
    begin
      logger.info "run into create new category"
      category = Category.new(create_params)
      if category.save!
        respond_to do |format|
          format.json { render :json => {return_code: 0, return_info: "success", id: category[:id], content: category[:content] }.to_json }
        end
      else
        raise "save category fails!"
      end
    rescue Exception => e
      logger.error "create new category error: #{e}"
      respond_to do |format|
        format.json { render :json => {return_code: -1, return_info: "fail"}.to_json }
      end
    end
  end

  def destroy
    begin
      logger.info "enter delete_tag"
      msg = @category.destroy ? "success" : "delete category fails"
      format.json { render :json => {return_code: 0, return_info: msg}.to_json }
    rescue Exception => e
      logger.error "delete category error: #{e}"
      respond_to do |format|
        format.json { render :json => {return_code: -1, return_info: "#{e}"}.to_json }
      end
    end
  end

  def update
    begin
      result = @category.update(update_params)
      if result
        respond_to do |format|
          format.json { render :json => {return_code: 0, return_info: "success"}.to_json }
        end
      else
        raise "update category fail!"
      end
    rescue Exception => e
      respond_to do |format|
        format.json { render :json => {return_code: -1, return_info: "#{e}"}.to_json }
      end
    end
  end
  

  private
  def create_params
    params.permit(:content)
  end
  def update_params
    params.permit(:content)
  end
  def find_category
    @category = Category.find(params[:id])
  end
end