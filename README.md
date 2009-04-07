twitrsvp
========
Another [oauth][oauth] experiment.  Organize folks with [sinatra][sinatra] and [twitter][twitter].  Try it out on [TwitRSVP][twitrsvp].

Installation
============
It's a sinatra app, packaged as a gem, deployed as a rack app.

    % rake repackage
    % sudo gem install pkg/twitrsvp*.gem

Your basic deps look like this:

    % sudo gem install oauth json haml chronic curb data_objects dm-core dm-types dm-validations dm-timestamps sinatra

Deployment
==========
Use [passenger][passenger] and a config.ru like this:

Example config.ru

    require 'rubygems'
    require 'twitrsvp'

    DataMapper.setup(:default, "mysql://atmos:s3cr3t@localhost/twitrsvp_production")

    ENV['TWIT_RSVP_READKEY'] = /\w{18}/.gen  # this should really be what twitter gives you
    ENV['TWIT_RSVP_READSECRET'] = /\w{24}/.gen # this should really be what twitter gives you

    class TwitRSVPSite < TwitRSVP::App
      set :public,      File.expand_path(File.dirname(__FILE__), "public")
      set :environment, :production
    end

    run TwitRSVPSite

testing
=======
You need [jacqui][jacqui]'s fork of fakeweb for the time being
    % git clone git://github.com/jacqui/fakeweb.git
    % cd fakeweb
    % rake repackage
    % sudo gem install pkg/fakeweb-1.2.0.gem

Then you just run rake...

[jacqui]: http://github.com/jacqui
[sinatra]: http://www.sinatrarb.com
[twitrsvp]: http://twitrsvp.com
[twitter]: http://twitter.com
[oauth]: http://oauth.net
[passenger]: http://modrails.com
