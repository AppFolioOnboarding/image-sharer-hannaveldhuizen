class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def index
    @images = Image.order('created_at DESC')
  end

  def create
    @image = Image.new(image_params)

    if @image.save
      redirect_to @image
    else
      render :new
    end
  end

  def show
    @image = Image.find(params[:id])
  end

  def tags_show
    @current_tag = params[:id]
    @images = Image.tagged_with(@current_tag)
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
