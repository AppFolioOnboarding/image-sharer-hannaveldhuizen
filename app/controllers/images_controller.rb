class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def index
    @images = Image.order('created_at DESC')

    @images = Image.tagged_with(params[:tag]) if params[:tag].present?
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

  def destroy
    @image = Image.find_by(id: params[:id])

    @image&.destroy

    redirect_to images_url
  end

  private

  def image_params
    params.require(:image).permit(:url, :tag_list)
  end
end
