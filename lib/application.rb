require 'hotcocoa'
# Load converter class for App logic
require 'lib/converter'

class Application

  include HotCocoa
  
  def start
    application :name => "Qif2csv" do |app|
      app.delegate = self
      window :size => [500, 180], :center => true, :title => "Qif2csv", :view => :nolayout do |win|
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
            # horiz << @console = text_field(:layout => {:align => :left, :expand => [:width]})
            horiz << @logger = label(:text => "No file loaded", :layout => {:expand => [:width]})
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
      log("File successfully loaded")
    end
  end
  
  # Choose where to save the output
  def choose_output
    panel = NSSavePanel.new
    panel.setPrompt("Save converted file")
    file_type = "csv"# @output_format.value
    panel.setAllowedFileTypes([file_type])
    panel.setExtensionHidden(false)
    panel.setCanSelectHiddenExtension(true)
    result = panel.runModalForDirectory(nil, file:"#{File.basename(@file)[0...-4]}.csv")
    if result == NSFileHandlingPanelOKButton
      @output_file = panel.filename
    else
      log("Cancelled conversion")
      nil
    end
  end
  
  # First prompt for output file, then run conversion with file reading and writing
  def convert
    # TODO: implementation
    output_file = choose_output
    return if output_file.nil?
    Converter.translate(@file, output_file)
    log("File conversion finished")
  end
  
  def log(msg)
    @logger.text = msg
  end
  
end

Application.new.start