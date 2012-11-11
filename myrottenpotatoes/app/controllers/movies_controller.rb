# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController
  def index
    @movies = Movie.all
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.html.haml by default
  end

  def new
    # default: render 'new' template
  end

  # in movies_controller.rb
  def create
    @movie = Movie.create!(params[:movie])
    redirect_to movies_path
    flash[:notice] = "#{@movie.title} was successfully created."
  end
  # in movies_controller.rb

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    respond_to do |client_wants|
      client_wants.html {  redirect_to movie_path(@movie)  } # as before
      client_wants.xml  {  render :xml => @movie.to_xml    }
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
end
# add to movies_controller.rb, anywhere inside
#  'class MoviesController < ApplicationController':

def search_tmdb
  # hardwire to simulate failure
  flash[:warning] = "'#{params[:search_terms]}' was not found in TMDb."
  redirect_to movies_path
end
end
