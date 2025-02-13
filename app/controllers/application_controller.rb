class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    redirect to '/recipes/new'
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    @recipes = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipes = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    @recipes = Recipe.find(params[:id])
    @recipes.name = params[:name]
    @recipes.ingredients = params[:ingredients]
    @recipes.cook_time = params[:cook_time]
    @recipes.save
    redirect to "/recipes/#{ @recipes.id }"
  end

  # create via post
  post '/recipes' do
    @recipes = Recipe.create(params)
    redirect to "/recipes/#{ @recipes.id }"
  end

  delete '/recipes/:id' do
    @recipes = Recipe.find(params[:id])
    @recipes.delete
    redirect to '/recipes'
  end
end
