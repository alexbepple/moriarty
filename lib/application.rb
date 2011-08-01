require 'rubygems' # disable this for a deployed application
require 'hotcocoa'

class Moriarty
  include HotCocoa

  def start
    application :name => "Moriarty" do |app|
      app.delegate = self
      window :size => [500, 500], :center => true, :view => :nolayout, :title => "Moriarty" do |win|
        win.will_close { exit }

        win.view = layout_view(:layout => {
            :expand => [:width, :height],
            :padding => 0, :margin => 0
        }) do |vert|
            vert << layout_view(
                :frame => [0, 0, 0, 40],
                :layout => {
                    :expand => [:width],
                    :start => false,
                },
            ) do |frame|
                frame << text_field(:layout => {
                    :expand => [:width],
                })
            end

            vert << scroll_view(
                :layout => {:expand => [:width, :height]}
            ) do |scroll|
                scroll << table_view(
                    :columns => [
                        column(:id => :name, :title => 'Name'),
                        column(:id => :location, :title => 'Location'), 
                    ], 
                    :data => [
                        {:name => 'README.md', :location => '/usr/local'},
                        {:name => 'git-completion.bash', :location => '/usr/local/etc/bash_completion.d'},
                    ]
                ) do |table|
                    table.setUsesAlternatingRowBackgroundColors(true)
                    table.on_double_action { table_doubleclicked }
                end
            end

        end
      end
    end
  end

  def table_doubleclicked
      NSWorkspace.sharedWorkspace.selectFile(
          '/usr/local/README.md', inFileViewerRootedAtPath: nil
      )
  end

end

Moriarty.new.start
