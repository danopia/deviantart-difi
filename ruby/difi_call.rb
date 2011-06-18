require 'rubygems'
require 'json'

# DiFi::Call.new 'MessageCenter', 'get_views', 17054129, 'oq:fb_activity:0:20:f:group=item'
# DiFi.MessageCenter.get_views(17054129, 'oq:fb_activity:0:20:f:group=item')

module DiFi
  class Call
    attr_accessor :object, :method, :params
    
    def initialize object=nil, method=nil, *params
      @object = object
      @method = method
      @params = params || []
    end
	
	  def to_s
		  [@object, @method, @params].to_json[1..-2]
	  end
    
    def inspect
      "#<DiFi::Call #{@object}.#{@method} #{params.inspect}>"
    end
  end

  class ObjectProxy
    attr_accessor :object, :session
    
    def initialize object, session=nil
      @object = object
      @session = session
    end
    
    def method_missing name, *stuff
      call = DiFi::Call.new @object, name, *stuff
      @session.call call if @session
    end
    
    def inspect
      "#<DiFi::Object #{@object}>"
    end
  end
  
  def self.method_missing name, *stuff
    p stuff if stuff != []
    ObjectProxy.new(name)
  end
end


