class InfluencersController < ApplicationController
  def index
    ImportInfluencersJob.perform_later unless Influencer.exists?(is_manual: false)
    @influencers = Influencer.ordered.page(params[:page]).per(8)

    if params[:query].present?
      @influencers = @influencers.where("fullname iLIKE ?", "%#{params[:query]}%")
    end
  end

  def create
    @influencer = Influencer.new(influencer_params)

    respond_to do |format|
      if @influencer.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.prepend("influencers", partial: "influencers/influencer", locals: { influencer: @influencer })
        end
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def new
    @influencer = Influencer.new
  end

  private

  def influencer_params
    params.expect(influencer: %i[external_id username fullname picture followers is_verified platform])
  end
end
