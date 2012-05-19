# Rakefile adapted from ryanb's (https://github.com/ryanb/dotfiles/)
require 'date'
require 'rake'
require 'pathname'

HOME = Pathname.new(ENV['HOME'])
SKIP_FILES = %w[.git .gitignore .gitmodules Rakefile].map{ |s| Pathname.new(s) }

desc "install the dot files into user's home directory"
task :install do
  safe_dir_path = HOME + DateTime.now.strftime('old-dotfiles-%Y%m%d-%H%M%S')
  paths_to_install = Pathname.getwd.children.reject { |c| SKIP_FILES.include?(c.basename) }
  paths_to_install.each { |path| install_path(path, safe_dir_path) }
end

def install_path(path, safe_dir_path)
  destination = HOME + ".#{path.basename}"
  backup_to_safe_dir(destination, safe_dir_path) if destination.exist?
  destination.make_symlink(path)
rescue => exn
  puts "Exception while attempting to install #{path}: #{exn}.  Moving on."
end

def backup_to_safe_dir(file, safe_dir_path)
  safe_dir_path.mkdir unless safe_dir_path.exist?
  backup_path = safe_dir_path + file.basename
  FileUtils.mv(file, backup_path)
end
