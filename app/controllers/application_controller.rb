
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do
    something = <<-HTML
      <ul>
        <li><a href="/articles">Go to articles</a></li>
        <li><a href="/articles/new">Create new entry</a></li>
      <ul>
    HTML
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end
  
  get '/articles/new' do
    erb :create
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id])
    erb :edit
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  post "/articles" do
    @article = Article.create(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(title: params[:title], content: params[:content])
    redirect to "/articles/#{@article.id}"
  end

  delete "/articles/:id" do
    @article = Article.find(params[:id])
    @article.destroy
  end

end
