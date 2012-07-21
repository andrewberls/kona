# Based on Rakefile from Slime Volley by Clay.io
# https://github.com/claydotio/Slime-Volley

require 'uglifier'
require 'listen'

SRC_PATH   = './src'   # Path to source files
BUILD_PATH = './build' # All individual coffeescript files are compiled to indiv. js files in this path
DIST_PATH  = './kona'  # Produces kona.js and kona.min.js in this path

VENDOR_FILENAMES = [
  # Hack here to support plain JS files
  'underscore.min'
]

FILENAMES = [
  'main',
  'engine',
  'entity',
  'keys',
  'sound',

  'game'
]

# Accepts an array of filenames and an optional
# base path, and flattens them into a string for cmd line usage
# e.g. join_filenames(['A.coffee', 'B.coffee'], './') => "./A.coffee ./B.coffee"
def join_filenames(filenames, base='./')
  filenames.map { |f| File.expand_path(File.join(base, f)) }.join(' ')
end

desc 'Compiles and concatenates source coffeescript files'
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
  else
    # Send a growl notification on failure if enabled
    system "growlnotify -m 'An error occured while compiling!' 2>/dev/null"
  end
end

# Watch and wait for changes, then call `rake build` to compile the changes
desc 'Waits for changes to files, then recompiles.'
task :watch do
  puts "Compiling and watching for changes in #{SRC_PATH}"
  system 'rake build'

  Listen.to SRC_PATH do
    puts 'File changed, recompiling...'
    system 'rake build'
  end
end

desc 'Remove all files in the build directory'
task :clean do
  count = 0
  [DIST_PATH, "#{DIST_PATH}.min"].each do |f|
    # Top level dist files
    File.delete(File.path("#{f}.js"))
    count += 1
  end

  Dir.foreach(BUILD_PATH) do |f|
    # Individual compiled files
    unless File.directory?(f)
      File.delete(File.join(BUILD_PATH, f))
      count += 1
    end
  end
  puts "Removed #{count} files."
end
