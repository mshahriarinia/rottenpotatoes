class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

#if the user has selected any combination of column sorting and restrict-by-rating constraints, 
#and then the user clicks to see the details of one of the movies (for example), when she clicks 
#the Back to Movie List on the detail page, the movie listing should “remember” the user’s sorting 
#and filtering settings from before. params superceds whatever is in session and should update it.
  def index
    @movies = Movie.scoped    # instead of all: in rails 3 all returns array.
    @all_ratings = Movie.ALL_RATINGS
    @ratings_filter_arr = Movie.ALL_RATINGS

    logger.info params

    if(! params[:ratings] && !session[:ratings])  #initially set to view all ratings
       params[:ratings] = @all_ratings
    end

    if(params[:order])
      session[:order] = params[:order]
    end

      params[:order] = session[:order]
      @order = params[:order]
      if(@order == "title")
        @movies = Movie.order("lower(#{@order})")
      elsif(@order == "release_date")
        @movies = Movie.order("lower(#{@order})")
      end

    #debugger
    if(params[:ratings])
      session[:ratings] = params[:ratings]
    end

      params[:ratings] = session[:ratings]
      @ratings_filter_arr = params[:ratings].keys
      @movies = @movies.where("rating in (?)", @ratings_filter_arr) #if params[:ratings]

  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
