class TagsController < ApplicationController
  before_action :set_tag, except: [:new]

  def new
    @tag = Tag.return_tag params[:name]
    if @tag.product_ids.include? params[:product_id].to_i
      render json: { status: 'existent' }
    else
      @tag.products << Product.find(params[:product_id])
      render json: { url: tag_path(@tag), status: 'tagged' }
    end
  end

  def set_tag
    @tag = Tag.find params[:tag_id] if params[:tag_id]
  end

  def delete
    @tag.destroy
    redirect_to root_path
  end
end
