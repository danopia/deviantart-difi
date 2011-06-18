DeviantART/DiFi Ruby Client
===========================

This library is being designed to leverage both HTML scraping and DiFi to allow
easy pragmatic access to DeviantART.

### Examples

    require 'difi'
    
    session = DiFi::Session.new
    session.auth 'myusername', 'mypassword1'
    
    session.Friends.getFriendsMenu(1)
    #=> [{"realname"=>"A Really Cool Guy", "lastvisit"=>"4w 5d", "groupname"=>"",
          "symbol"=>"~", "usericon"=>"5", "username"=>"Coz-man",
          "avatar"=>"http://a.deviantart.net/avatars/c/o/coz-man.gif?1",
          "groupid"=>nil},
         . . .
        ]

See this repo's doc for more API calls.

