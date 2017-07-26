module Api
  class EventsController < ApplicationController
    respond_to :json
    before_action :set_event, only: [:update, :destroy]

    def index
      respond_with Event.order("#{sort_by} #{order}")
    end

    def search
      query = params[:query]
      events = Event.where('title LIKE ? OR category LIKE ? OR description LIKE ? OR tags LIKE ?  OR url LIKE ?',
                           "%#{query}%", "%#{query}%", "%#{query}%","%#{query}%", "%#{query}%")

      respond_with events
    end

    def create
      event = Event.new(event_params)
      if event.save
        respond_with :api, event, status: :ok
      else
        render json: { errors: event.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      if @event.update(event_params)
        respond_with @event, status: :ok
      else
        render json: { errors: @event.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      @event.destroy
      head :ok
    end

    private

    def event_params
      params.require(:event).permit(:title, :description, :category, :tags, :url)
    end

    def set_event
      @event = Event.find(params[:id])
    end

    def sort_by
      %w(title
         category
         description
         tags
         url).include?(params[:sort_by]) ? params[:sort_by] : 'title'
    end

    def order
      %w(asc desc).include?(params[:order]) ? params[:order] : 'asc'
    end
  end
end
