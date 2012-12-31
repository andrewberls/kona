require 'json'
require 'uglifier'
require 'fileutils'

desc 'Compiles and concatenates all coffeescript source files'
task :build do
  # Parse configuration files
  js        = []
  config    = read_config()
  src_path  = File.expand_path(config["src_path"])
  lib_path  = File.expand_path(config["lib_path"]) if config["lib_path"]
  tmp_path  = File.expand_path("__tmp")
  manifest  = JSON.parse(File.open(File.join(src_path, "manifest.json")).read)
  files     = manifest["files"].map do |f|
    f = File.join(src_path, "#{f}.coffee")
  end.join(' ')

  # Compile CoffeeScripts to an intermediate directory
  `coffee -b --output #{tmp_path} --compile #{files}`

  if $?.to_i == 0
    # Read any lib files
    if !lib_path.nil?
      Dir.glob(File.join(lib_path, "*.js")) { |f| js << File.read(f) }
    end

    # Read intermediate compiled source files in specified order
    js << manifest["files"].map do |f|
      path = File.expand_path(File.join(tmp_path, "#{f}.js"))
      File.read(path)
    end

    js    = js.join("\n")
    minjs = Uglifier.new.compile(js)

    # Write build files and remove intermediate compiled source files
    build_path = (!config["build_path"].nil?) ? File.expand_path(config["build_path"]) : "."
    build_file = config["build_file"]
    FileUtils.mkpath(build_path)
    File.open(File.join(build_path, "#{build_file}.js"), 'w') { |f| f.write(js) }
    File.open(File.join(build_path, "#{build_file}.min.js"), 'w') { |f| f.write(minjs) }
    FileUtils.rm_rf(tmp_path)

    puts "Compiled successfully."
  else
    puts "An error occurred while compiling!"
    `growlnotify -m 'An error occurred while compiling!' 2>/dev/null`
  end
end


desc 'Generate docs'
task :docs do
  src_path = File.expand_path(read_config["src_path"])
  `docco #{src_path}/*.coffee`
end



# Parse json config file in project root directory
def read_config
  JSON.parse(File.read('config.json'))
end
