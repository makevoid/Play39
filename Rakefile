path = File.expand_path "../", __FILE__

desc "Starts installation process"
task :install do
  config = "#{path}/lib/config"
  file = "#{config}/thin.yml"
  contents = File.read("#{config}/thin.default.yml")
  File.open(file, "w") do |f|
    f.write(contents.gsub(/HOME/, File.expand_path("~/")))
  end
end