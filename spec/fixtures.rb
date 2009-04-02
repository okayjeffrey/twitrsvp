TwitRSVP::User.fix {{
  :twitter_id => /\d{8,14}/.gen, 
  :name => "#{/\w{2,8}/.gen} #{/\w{3,12}/.gen}", 
  :token => /\w{8,16}/.gen, 
  :secret => /\w{8,16}/.gen
}}

TwitRSVP::Event.fix {{
  :user_id  => TwitRSVP::User.gen.id,
  :name     => /\w{8,20}/.gen,
  :place    => /\w{8,20}/.gen,
  :map_link => 'http://maps.google.com/maps?client=safari&q=eiffel+tower',
  :end_at   => Time.now + 3600,
  :start_at => Time.now + 7200,
  :attendees => 7.of { TwitRSVP::Attendee.make }
}}

TwitRSVP::Attendee.fix {{
  :user_id  => TwitRSVP::User.gen.id,
}}

TwitRSVP::Attendee.fix(:standalone) {{
  :user_id  => TwitRSVP::User.gen.id,
  :event_id => TwitRSVP::Event.gen.id,
}}