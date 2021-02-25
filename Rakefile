require 'rake'
require 'erb'
require 'fileutils'


$replace_all = false

desc "install the dot files into user's home directory"
task :install do
  Dir['*'].each do |file|
    next if %w[Rakefile README.rdoc LICENSE config fonts bin].include? file
    sync(file)
  end

  Dir['config/*'].each do |file|
    sync(file)
  end

  Dir['bin/*'].each do |file|
    sync(file, hidden: false)
  end

  Dir['fonts/*'].each do |file|
    sync(file)
  end
  system "fc-cache -f"
end

def sync(file, target_dir: ENV['HOME'], hidden: true)
  filepath = File.join(
    target_dir,
    hidden ? ".#{file.sub('.erb', '')}" : "#{file.sub('.erb', '')}"
  )

  target_dirname = File.dirname(filepath)
  FileUtils.mkdir_p(target_dirname) unless File.directory?(target_dirname)

  if File.exist?(filepath)
    if File.identical? file, filepath
      puts "identical #{filepath}"
    elsif $replace_all
      replace_file(file, filepath)
    else
      print "overwrite #{filepath}? [ynaq] "
      case $stdin.gets.chomp
      when 'a'
        $replace_all = true
        replace_file(file, filepath)
      when 'y'
        replace_file(file, filepath)
      when 'q'
        exit
      else
        puts "skipping #{filepath}"
      end
    end
  else
    link_file(file, filepath)
  end
end

def replace_file(src_file, filepath)
  system %Q{rm -rf "#{filepath}"}
  link_file(src_file, filepath)
end

def link_file(src_file, filepath)
  if src_file =~ /.erb$/
    File.open(filepath, 'w') do |new_file|
      new_file.write ERB.new(File.read(src_file)).result(binding)
    end
  else
    puts "linking #{filepath}"
    system %Q{ln -s "$PWD/#{src_file}" "#{filepath}"}
  end
end
