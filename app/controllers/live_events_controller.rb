class LiveEventsController < ApplicationController
  def index
    @live_events = current_user.live_events
  end
  
  def new
    @live_event = current_user.live_events.new
  end

  def create
    @live_event = current_user.live_events.new(live_event_params)
    if @live_event.save
      flash[:notice] = "予定を登録しました"
      redirect_to live_events_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @live_event = current_user.live_events.find(params[:id])
  end

  def update
    @live_event = current_user.live_events.find(params[:id])
    if @live_event.update(live_event_params)
      flash[:notice] = "予定を編集しました"
      redirect_to live_events_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @live_event = current_user.live_events.find(params[:id])
    if @live_event.destroy
      flash[:notice] = "予定を削除しました"
      redirect_to live_events_path
    end
  end

  # google Places API(New)で会場検索
  def venue_search
    query = params[:query]

    response = Faraday.post(
      "https://places.googleapis.com/v1/places:autocomplete"
    ) do |req|
      req.headers["Content-Type"] = "application/json"
      req.headers["X-Goog-Api-Key"] = Rails.application.credentials.google_maps[:api_key]
      req.headers["X-Goog-FieldMask"] = "suggestions.placePrediction.text,suggestions.placePrediction.placeId"
      req.body = {
        input: query,
        includedRegionCodes: ["jp"]
      }.to_json
    end

    render json: JSON.parse(response.body)
  end

  private

  def live_event_params
    params.require(:live_event).permit(
      :title,
      :artist_name,
      :event_date,
      :venue_name,
      :address,
      :latitude,
      :longitude,
      :place_id
    )
  end
end
