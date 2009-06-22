require 'hotcocoa'

require 'lib/converter'

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
          # vert << layout_view(:frame => [0, 0, 0, 40], :mode => :horizontal, :layout => {:padding => 0, :margin => 0, :start => false, :expand => [:width]}) do |horiz|
          #   # FIXME: turn into a PopupButton
          #   horiz << @output_format = label(:text => "File: ", :layout => {:align => :left, :expand => [:width]})
          #   # FIXME: turn into a checkbox ()
          #   horiz << @windows_formatted = button(:title => "Format for windows", :layout => {:align => :left})
          # end
          # Output dialog and button
          vert << layout_view(:frame => [0, 0, 0, 40], :mode => :horizontal, :layout => {:padding => 0, :margin => 0, :start => false, :expand => [:width]}) do |horiz|
            horiz << @console = text_field(:layout => {:align => :left, :expand => [:width]})
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
    load_file
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
    panel = NSOpenPanel.new
    panel.setCanChooseFiles(true)
    panel.setCanChooseDirectories(false)
    panel.runModalForTypes(["qif"])
    @file = panel.filename
    unless @file.nil?
      @file_label.text = "File: #{@file}"
    end
    log("Loaded file: #{@file}")
  end
  
  # Choose where to save the output
  def choose_output
    panel = NSSavePanel.new
    panel.setPrompt("Save converted file")
    file_type = "csv"# @output_format.value
    panel.setAllowedFileTypes([file_type])
    result = panel.runModal
    if result == NSFileHandlingPanelOKButton
      @output_file = panel.filename
    else
      nil
    end
  end
  
  # First prompt for output file, then run conversion with file reading and writing
  def convert
    # TODO: implementation
    output_file = choose_output
    return if output_file.nil?
    Converter.translate(@file, output_file)
  end
  
  def log(msg)
    puts msg
    # @console.selectText += "\n#{msg}"
  end
  
end

Application.new.start