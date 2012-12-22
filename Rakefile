# Based on Rakefile from Slime Volley by Clay.io
# https://github.com/claydotio/Slime-Volley

require 'uglifier'
require 'listen'
require 'fileutils'

SRC_PATH   = './src'   # Path to source files
BUILD_PATH = './build' # Intermediate compiled source files will be stored here
DIST_PATH  = './kona'  # Produces kona.js and kona.min.js at this path

VENDOR_FILENAMES = [
  # Hack here to support plain JS files
  'underscore.min'
]

FILENAMES = [
  'kona',
  'utils',
  'canvas',
  'engine',
  'scenes',
  'sprite',
  'entity',
  'tiles',
  'collectable',
  'keys',
  'sound',
  'weapons',
  'projectiles'
]

# Accepts an array of filenames and an optional
# base path, and flattens them into a string for cmd line usage
# e.g. join_filenames(['A.coffee', 'B.coffee'], './') => "./A.coffee ./B.coffee"
def join_filenames(filenames, base='./')
  filenames.map { |f| File.expand_path(File.join(base, f)) }.join(' ')
end



desc 'Compiles and concatenates all coffeescript source files'
task :build do
  vendor_files = join_filenames(
    VENDOR_FILENAMES.map { |file| "#{file}.js" }
  )

  files = join_filenames(
    FILENAMES.map { |file| "#{file}.coffee" },
    SRC_PATH
  )

  # Compile everything
  `coffee -b --output #{BUILD_PATH} --compile #{files}`
  if $?.to_i == 0
    puts "Compiled successfully."
    js = []
    js << VENDOR_FILENAMES.map do |file|
      IO.read File.join('./vendor', File.basename("#{file}.js"))
    end

    js << FILENAMES.map do |file|
      IO.read File.join(BUILD_PATH, File.basename("#{file}.js"))
    end

    js = js.join "\n"

    # Minify and write concatenated dist files
    minjs = Uglifier.new.compile(js)
    File.open("#{DIST_PATH}.js", 'w') { |f| f.write(js) }
    File.open("#{DIST_PATH}.min.js", 'w') { |f| f.write(minjs) }

    FileUtils.rm_rf BUILD_PATH
  else
    # Send a growl notification on failure if enabled
    system "growlnotify -m 'An error occured while compiling!' 2>/dev/null"
  end
end


desc 'Waits for changes to files, then recompiles.'
task :watch do
  puts "Compiling and watching for changes in #{SRC_PATH}"
  system 'rake build'

  Listen.to SRC_PATH do
    puts 'File changed, recompiling...'
    system 'rake build'
  end
end


desc 'Generate docs'
task :docs do
  system "docco #{SRC_PATH}/*.coffee"
end


desc 'Build the demo'
task :demo do
  files = [
    'demo/demo.coffee'
  ]
  `coffee -b --output demo/js --compile #{files.join(' ')}`
end
