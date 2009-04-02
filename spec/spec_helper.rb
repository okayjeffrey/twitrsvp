$TESTING=true
$:.push File.join(File.dirname(__FILE__), '..', 'lib')
require 'rubygems'
require 'randexp'
require 'twitrsvp'
require 'do_sqlite3'
require 'dm-sweatshop'
require 'pp'

require File.dirname(__FILE__)+'/fixtures'

DataMapper.setup(:default, 'sqlite3::memory:')
DataMapper.auto_migrate!