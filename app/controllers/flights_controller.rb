class FlightsController < ApplicationController
  # attr_reader :flights_list
  def index
    @flights_list = Flight.new.get_all_flights.paginate(:page => params[:page], :per_page => 20)
  end

  def show

  end

  def search_flight
    to = flight_params[:to_id]
    from = flight_params[:from_id]
    dept_time  =  flight_params[:dept_time]
    if valid_airports(from, to).nil?
      @flights_list = Flight.new.get_flight(to, from , dept_time)
      if @flights_list.empty?
        flash[:notice] = "No flights found. Please make another search."
      else
        return show_search(@flights_list)
      end
    end
    redirect_to root_url
  end

  def show_search(list)
    render "show_search"
  end

  def home
    return "show_search"
  end

  # def home
  #   if @flights_list
  #     search_flight
  #   end

  # end

  def create

  end

  protected

  def flight_params
      params.require(:flight).permit(:from_id, :to_id, :dept_time)
  end

  def  valid_airports(from, to)
    if to.empty? || from.empty?
      flash[:notice] = "Select your departure and destination airports."
    elsif to == from
      flash[:notice] = "Departure and Destination airports can not be the same."
    end
  end

end