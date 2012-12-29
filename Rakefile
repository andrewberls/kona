# Based on Rakefile from Slime Volley by Clay.io
# https://github.com/claydotio/Slime-Volley
#
# Run 'bundle install' to install required gems

require 'uglifier'
require 'fileutils'


# --------------------------
# FILE CONFIGURATION
# --------------------------
VENDOR_PATH = 'src/lib' # Path to vendor scripts (ex: Underscore)
SRC_PATH    = 'src'     # Path to source files
BUILD_PATH  = 'build'   # Directory for intermediate compiled source files
DIST_PATH   = 'kona'    # Produces <name>.js and <name>.min.js at this path

VENDOR_FILES = [
  'underscore.min'
]
SOURCE_FILES = [
  'kona',
  'utils',
  'canvas',
  'engine',
  'scenes',
  'entity',
  'animation',
  'tiles',
  'collectable',
  'keys',
  'sound',
  'menu',
  'weapons',
  'projectiles'
]


# --------------------------
# TASKS
# --------------------------
desc 'Compiles and concatenates all coffeescript source files'
task :build do
  sources = SOURCE_FILES.map { |file| "#{file}.coffee" }
  files   = join_filenames(sources, SRC_PATH)
  js      = []

  `coffee -b --output #{BUILD_PATH} --compile #{files}`
  if $?.to_i == 0
    js << VENDOR_FILES.map { |file| IO.read source_js(VENDOR_PATH, file) }
    js << SOURCE_FILES.map { |file| IO.read source_js(BUILD_PATH, file) }

    js    = js.join("\n")
    minjs = Uglifier.new.compile(js)
    File.open("#{DIST_PATH}.js", 'w') { |f| f.write(js) }
    File.open("#{DIST_PATH}.min.js", 'w') { |f| f.write(minjs) }

    FileUtils.rm_rf BUILD_PATH
    puts "Compiled successfully."
  else
    puts "An error occurred while compiling!"
    `growlnotify -m 'An error occurred while compiling!' 2>/dev/null`
  end
end

desc 'Generate docs'
task :docs do
  `docco #{SRC_PATH}/*.coffee`
end

desc 'Build the demo'
task :demo do
  files = ['demo/demo.coffee']
  `coffee -b --output demo/js --compile #{files.join(' ')}`
end


# --------------------------
# UTILITIES
# --------------------------
# Takes an array of filenames and an optional base path,
# and flattens them into a string for cmd line usage
# ex: join_filenames(['A.coffee', 'B.coffee'], './') => "./A.coffee ./B.coffee"
def join_filenames(filenames, base='./')
  filenames.map { |f| File.expand_path(File.join(base, f)) }.join(' ')
end

# Get the path of a compiled javascript file
def source_js(dir, file)
  File.join(dir, File.basename("#{file}.js"))
end
