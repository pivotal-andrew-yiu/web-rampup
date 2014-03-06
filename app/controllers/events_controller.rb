class EventsController < ApplicationController
  include ApiEndpoints
  include SessionsHelper
  include UsersHelper

  def index
    @artistName = params['artistName']
    @artistId = params['artistId']
    
    if !params['static_pages'].nil?
      @zipcode = params['static_pages']['zipcode']
    else
      @zipcode = params['zipcode']
    end

    if !@artistId.nil?
      @events = JSON.parse(get_events_json({'artistId' => @artistId}))['Events']
      @events_for_text = 'Listing events for ' + @artistName
    elsif !@zipcode.nil?
      @events = JSON.parse(get_events_json({'zipCode' => @zipcode}))['Events']
      @events_for_text = 'Listing events in the ' + @zipcode + ' area'
    elsif @artistId.empty? || @zipcode.empty?
      redirect_to :back
    else
      @events = nil
      @events_for_text = ""
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
  end

  # POST /events
  # POST /events.json
  def create
  
    params.each do |key, value|
      puts "#{key} is #{value}"
    end

    if !current_user.events.find_by_event_id(params['Id'])
      artist_list = []
      params['Artists'].each do |artist|
        artist_list << artist['Name']
      end
      @event = current_user.events.create( event_id: params['Id'], venue_name: params['Venue']['Name'], date: params['Date'], artist_names: artist_list.join(', '))
    end

    respond_to do |format|
      if @event && @event.save
        format.html { 
          if params['artistId']
            redirect_to events_path('artistId' => params['artistId'])
          elsif params['zipCode']
            redirect_to events_path('zipcode' => params['zipCode'])
          else
            redirect_to :back
          end 
        }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { 
          if params['artistId']
            redirect_to events_path('artistId' => params['artistId'])
          elsif params['zipCode']
            redirect_to events_path('zipcode' => params['zipCode'])
          else
            redirect_to :back
          end
        }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy

    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html {
        if params['artistId']
          redirect_to events_path('artistId' => params['artistId'])
        elsif params['zipCode']
          redirect_to events_path('zipcode' => params['zipCode'])
        else
          redirect_to :back
        end
      }
      format.json { head :no_content }
    end
  end
end
