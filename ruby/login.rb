require 'form'

class Login
  attr_reader :session
  
  def initialize session
    @session = session
  end
  
  def auth username, password
    form = FakeForm.new 'post', 'https://www.deviantart.com/users/login'
    
    form['username']   = username
    form['password']   = password
    form['ref']        = 'http://www.deviantart.com/'
    form['reusetoken'] = '1'
    
    page = @session.agent.submit(form)
    !page.title.end_with?('deviantART : Log In')
  end

end

