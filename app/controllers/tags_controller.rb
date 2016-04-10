class TagsController < ApplicationController
  before_action :find_tag , only: [:update, :destroy]
  def index
    @tags = Tag.order(created_at: :desc)
  end
  def show
    
  end

  def new
    
  end

  def create
    begin
      logger.info "run into create new tag"
      tag = Tag.new(create_params)
      if tag.save!
        respond_to do |format|
          format.json { render :json => {return_code: 0, return_info: "success", id: tag[:id], content: tag[:content] }.to_json }
        end
      else
        raise "save tag fails!"
      end
    rescue Exception => e
      logger.error "create new tag error: #{e}"
      respond_to do |format|
        format.json { render :json => {return_code: -1, return_info: "fail"}.to_json }
      end
    end
  end

  def destroy
    begin
      logger.info "enter delete_tag"
      if @tag.destroy
        respond_to do |format|
          format.json { render :json => {return_code: 0, return_info: "success"}.to_json }
        end
      else
        raise "delete tag error"
      end
    rescue Exception => e
      logger.error "delete tag error: #{e}"
      respond_to do |format|
        format.json { render :json => {return_code: -1, return_info: "#{e}"}.to_json }
      end
    end
  end

  def update
    begin
      result = @tag.update(update_params)
      if result
        respond_to do |format|
          format.json { render :json => {return_code: 0, return_info: "success"}.to_json }
        end
      else
        raise "update tag fail!"
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
  def find_tag
    @tag = Tag.find(params[:id])
  end
end