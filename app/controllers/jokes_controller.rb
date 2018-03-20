class JokesController < ApplicationController
  before_action :find_joke , only: [:edit, :update, :destroy]
  def index
    @jokes = Joke.search(search_params)
    respond_to do |format|
      format.html
      format.js { render :search }
    end
  end

  def show
    
  end

  def new
    
  end

  def search
    @jokes = Joke.search(search_params)
    respond_to do |format|
      format.js
    end
  end

  def create
    begin
      logger.info "enter create_joke"
      joke = Joke.new(create_params)
      if joke.save!
        redirect_to jokes_path
      else
        flash.now[:alert] = "create joke fail, try again in a few minute."
        render action: "new"
      end
    rescue Exception => e
      logger.error "create joke error: #{e}"
    end
  end

  def destroy
    begin
      logger.info "enter delete_joke"
      if @joke.destroy
        respond_to do |format|
          format.json { render :json => {return_code: 0, return_info: "success"}.to_json }
        end
      else
        raise "delete joke error"
      end
    rescue Exception => e
      logger.error "delete joke error: #{e}"
      respond_to do |format|
        format.json { render :json => {return_code: -1, return_info: "#{e}"}.to_json }
      end
    end
  end

  def edit
    respond_to do |format|
      format.html {render :edit, layout: false}
    end
  end

  def update
    begin

      # pad_params_with_default_tag_id
      # used to clear tag
      pad_update_params = update_params
      pad_update_params[:tag_ids] = [] unless pad_update_params.key?(:tag_ids)
      
      p "pad_update_params: #{pad_update_params}"
      result = @joke.update(pad_update_params)
      if result
        respond_to do |format|
          format.json { render :json => {return_code: 0, return_info: "success"}.to_json }
        end
      else
        raise "update joke fail!"
      end
    rescue Exception => e
      respond_to do |format|
        format.json { render :json => {return_code: -1, return_info: "#{e}"}.to_json }
      end
    end
  end

  private

  def create_params
    params.require(:joke).permit(:content, :point, :keyword, :category_ids => [], :tag_ids => [])
  end
  def find_joke
    @joke = Joke.find(params[:id])
  end
  def update_params
    params.permit(:content, :point, :keyword, :category_ids => [], :tag_ids => [])
  end
  def search_params
    params.permit(:trash, :content, :type, :order, :page)
  end
end