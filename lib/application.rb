require 'hotcocoa'

# Replace the following code with your own hotcocoa code

class Application

  include HotCocoa
  
  def start
    application :name => "Qif2csv" do |app|
      app.delegate = self
      window :size => [500, 500], :center => true, :title => "Qif2csv", :view => :nolayout do |win|
        win.will_close { exit }
        
        # Window elements layout
        win.view = layout_view(:layout => {:expand => [:width, :height], :padding => 0, :margin => 0, :start => false}) do |vert|
          # Title
          vert << label(:text => "Qif2csv - .qif file conversion tool", :layout => {:align => :center, :start => false})
          # File display
          vert << layout_view(:frame => [0, 0, 0, 40], :mode => :horizontal, :layout => {:padding => 0, :margin => 0, :start => false, :expand => [:width]}) do |horiz|
            horiz << @file_label = label(:text => "File: ", :layout => {:expand => [:width]})
            horiz << @file_open_button = button(:title => "Open", :layout => {:align => :right}) do |b|
              b.on_action { load_file }
            end
          end
          # Formatting options
          vert << layout_view(:frame => [0, 0, 0, 40], :mode => :horizontal, :layout => {:padding => 0, :margin => 0, :start => false, :expand => [:width]}) do |horiz|
            # FIXME: turn into a PopupButton
            horiz << @file_label = label(:text => "File: ", :layout => {:align => :left, :expand => [:width]})
            # FIXME: turn into a checkbox ()
            horiz << @windows_formatted = button(:title => "Format for windows", :layout => {:align => :left})
          end
          # Output dialog and button
          vert << layout_view(:frame => [0, 0, 0, 40], :mode => :horizontal, :layout => {:padding => 0, :margin => 0, :start => false, :expand => [:width]}) do |horiz|
            horiz << @feed_field = text_field(:layout => {:align => :left, :expand => [:width]})
            horiz << @convert_button = button(:title => "Convert", :layout => {:align => :right}) do |b|
              b.on_action { convert }
            end
          end
        end
      end
    end
  end
  
  # file/open
  def on_open(menu)
  end
  
  # file/new 
  def on_new(menu)
  end
  
  # help menu item
  def on_help(menu)
  end
  
  # This is commented out, so the minimize menu item is disabled
  #def on_minimize(menu)
  #end
  
  # window/zoom
  def on_zoom(menu)
  end
  
  # window/bring_all_to_front
  def on_bring_all_to_front(menu)
  end
  
  # When the open button is clicked
  def load_file
    
  end
  
  def convert
    # TODO: implementation
  end
  
end

Application.new.start