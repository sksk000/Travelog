class Public::PlacesController < ApplicationController
  def new
    @place = Place.new
    @post_id = params[:post_id]
    @place_num = Place.where(post_id: @post_id).maximum(:place_num)

    # 検索して存在しない場合は0を代入する
    if @place_num == nil
      @place_num = 0
    else
      @place_num = @place_num + 1
    end

  end


  def create
    @place = Place.new(place_params)
    @place.post_id = params[:post_id]
    save_place_num()

    if @place.save
      redirect_to post_path(@place.post_id)
    else
      render :new
    end
  end

  def edit
    @place = Place.where(post_id: params[:post_id]).order(:place_num)
    @post_id = params[:post_id]
  end

  def update
    datas = params[:place]
    datas.each do | id, attrs |
      data = Place.find(id)
      data.update(update_params(attrs))
    end
    redirect_to post_path(params[:post_id])
  end

  private
  def place_params
    params.require(:place).permit(:address, :place_name, :comment)
  end

  def update_params(attrs)
    attrs.permit(:place_name, :address, :comment)
  end

  def save_place_num
    target_num = params[:place][:place_num]
    if target_num == "新規追加"
      max_num = Place.where(post_id: @post_id).maximum(:place_num)
      if max_num == nil
        @place.place_num = 0
      else
        @place.place_num = max_num + 1
      end
    else
      @place.place_num = params[:place][:place_num]

      datas= Place.where(post_id: params[:post_id]).where('place_num >= ?', target_num)
      Place.transaction do
        datas.find_each do | data |
          data.update!(place_num: data.place_num + 1)
        end
      end

    end
  end
end
