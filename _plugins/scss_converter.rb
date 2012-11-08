#
# Jekyll Generator for SCSS
# Based on: https://gist.github.com/2874934
#
# (File paths in this description relative to jekyll project root directory)
# Place this file in ./_plugins
# Place .scss files in ./styles
# Compiles .scss files in ./styles to .css files in whatever directory you indicated in your config
# Config file placed in ./styles/config.rb
#

require 'sass'
require 'pathname'
require 'compass'
require 'compass/exec'

module Jekyll

  class CompassGenerator < Generator
    safe true

    def generate(site)
      Dir.chdir File.expand_path('../styles', File.dirname(__FILE__)) do
        Compass::Exec::SubCommandUI.new(%w(compile)).run!
      end
    end

  end

end
