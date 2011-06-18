require 'login'
require 'form'
require 'difi_call'

require 'cgi'

require 'rubygems'
require 'mechanize'
require 'json'

module DiFi
  class Session
    attr_reader :agent, :userinfo, :authdata, :level
    
    def initialize
      @agent = Mechanize.new
      @level = 0
    end
    
    def auth username, password
      Login.new(self).auth(username, password)
      
      @userinfo = CGI::unescape(@agent.cookies.select{|c| c.name=='userinfo'}.first.value)
      @authdata = CGI::unescape(@agent.cookies.select{|c| c.name=='auth'}.first.value)
      @level = 2
    end

    def call call, hidden=true
			page = if hidden
			  form = FakeForm.new 'post', 'http://deviantart.com/global/difi/'
    
        form['ui']  = @userinfo
        form['c[]'] = call.to_s
        form['t']   = 'json'

        @agent.submit form
			else
        @agent.get("http://deviantart.com/global/difi/?c[]=#{CGI::escape(call.to_s)}&t=json")
      end
      
      json = JSON.parse(page.body)['DiFi']
      
      raise "Remote DiFi #{json['status']}: #{json['response']['error']}" if json['status'] != 'SUCCESS'
      
      json['response']['calls'][0]['response']['content']
	  end
  
    def method_missing name, *stuff
      p stuff if stuff != []
      ObjectProxy.new(name, self)
    end
  end
end

