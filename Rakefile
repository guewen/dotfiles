require 'rake'
require 'erb'


$replace_all = false

desc "install the dot files into user's home directory"
task :install do
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE config].include? file
    sync(file)
  end

  Dir['config/*'].each do |file|
    sync(file)
  end
end

def sync(file, target_dir=ENV['HOME'])
  if File.exist?(File.join(target_dir, ".#{file.sub('.erb', '')}"))
    if File.identical? file, File.join(target_dir, ".#{file.sub('.erb', '')}")
      puts "identical ~/.#{file.sub('.erb', '')}"
    elsif $replace_all
      replace_file(file)
    else
      print "overwrite ~/.#{file.sub('.erb', '')}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        $replace_all = true
        replace_file(file)
      when 'y'
        replace_file(file)
      when 'q'
        exit
      else
        puts "skipping ~/.#{file.sub('.erb', '')}"
      end
    end
  else
    link_file(file)
  end
end

def replace_file(file)
  system %Q{rm -rf "$HOME/.#{file.sub('.erb', '')}"}
  link_file(file)
end

def link_file(file)
  if file =~ /.erb$/
    puts "generating ~/.#{file.sub('.erb', '')}"
    File.open(File.join(ENV['HOME'], ".#{file.sub('.erb', '')}"), 'w') do |new_file|
      new_file.write ERB.new(File.read(file)).result(binding)
    end
  else
    puts "linking ~/.#{file}"
    system %Q{ln -s "$PWD/#{file}" "$HOME/.#{file}"}
  end
end
