class Share39 < Sinatra::Base
  
  delete "/paths/*" do |path|
    @path = Path.get(path)
    halt_not_found if @path.nil?
    @path.destroy
    flash[:error] = "path deleted!"
    redirect "/settings"
  end

  get "/settings" do
    @paths = Path.all
    haml :settings
  end


  post "/paths" do
    begin
      @path = Path.create(name: params[:path])
    rescue DirNotFound
      flash[:error] = "Directory not found: '#{params[:path]}'"
    end
    if @path
      log_errors_for(@path){ puts "lol" }
      flash[:notice] = "Path added!"
    end
    redirect "/settings"
  end

  post "/reindex" do
    time = Time.now
    Indexer.new.index
    @timer = Time.now - time
    flash[:notice] = "Files indexing completed! (in #{@timer.round(1)} sec)"
    redirect "/settings"
  end  
end