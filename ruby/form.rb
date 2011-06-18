require 'rubygems'
require 'mechanize'

class FakeFormNode < Hash
  def search(stuff); []; end
end

class FakeForm < Mechanize::Form
  def initialize method, action
    form = FakeFormNode.new
    
    form['method'] = method
    form['action'] = action
    
    super(form)
  end
  
  def []= name, value
    @fields << Mechanize::Form::Text.new('name' => name, 'value' => value)
  end
end

