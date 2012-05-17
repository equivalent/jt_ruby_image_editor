#! ruby ``
Dir['./lib/**/*.rb'].each {|file| require file }
Interface.new
