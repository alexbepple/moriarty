require 'rubygems' # disable this for a deployed application
require 'hotcocoa'

class Moriarty
  include HotCocoa

  def start
    application :name => "Moriarty" do |app|
      app.delegate = self
      window :frame => [100, 100, 500, 500], :title => "Moriarty" do |win|
        win << label(:text => "Hello from HotCocoa", :layout => {:start => false})
        win.will_close { exit }
      end
    end
  end

end

Moriarty.new.start
