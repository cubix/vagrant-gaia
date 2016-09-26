$:.unshift File.expand_path("../lib", __FILE__)
require "vagrant-gaia/version"

Gem::Specification.new do |s|
  s.name          = 'vagrant-gaia'
  s.version       = VagrantPlugins::GuestGaia::VERSION
  s.date          = '2016-09-04'
  s.platform      = Gem::Platform::RUBY
  s.license       = "GPL-2.0"
  s.authors       = ["Andrew Rimes"]
  s.email         = "aar@pobox.com"
  s.summary       = "Check Point Gaia guest for Vagrant"
  s.description   = "Adds Check Point's Gaia secure operating system as a guest for Vagrant."
  s.homepage      = "https://github.com/cubix/vagrant-gaia"
  s.required_rubygems_version = ">= 1.3.6"

  # Note that the entire gitignore(5) syntax is not supported, specifically
  # the "!" syntax, but it should mostly work correctly.
  root_path      = File.dirname(__FILE__)
  all_files      = Dir.chdir(root_path) { Dir.glob("**/{*,.*}") }
  all_files.reject! { |file| [".", ".."].include?(File.basename(file)) }
  gitignore_path = File.join(root_path, ".gitignore")
  gitignore      = File.readlines(gitignore_path)
  gitignore.map!    { |line| line.chomp.strip }
  gitignore.reject! { |line| line.empty? || line =~ /^(#|!)/ }

  unignored_files = all_files.reject do |file|
    # Ignore any directories, the gemspec only cares about files
    next true if File.directory?(file)

    # Ignore any paths that match anything in the gitignore. We do
    # two tests here:
    #
    #   - First, test to see if the entire path matches the gitignore.
    #   - Second, match if the basename does, this makes it so that things
    #     like '.DS_Store' will match sub-directories too (same behavior
    #     as git).
    #
    gitignore.any? do |ignore|
      File.fnmatch(ignore, file, File::FNM_PATHNAME) ||
        File.fnmatch(ignore, File.basename(file), File::FNM_PATHNAME)
    end
  end

  s.files         = unignored_files
  s.executables   = unignored_files.map { |f| f[/^bin\/(.*)/, 1] }.compact
  s.require_path  = 'lib'
end
