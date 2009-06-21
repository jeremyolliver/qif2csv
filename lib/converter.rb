class Converter
  
  def self.translate(input_filepath, output_filepath)
    # Read the input
    file = File.read(input_filepath)
    file.gsub!("\r\n", "\n") # Remove windows newline characters, for comformity of processing files
    
    entries = file.split("^\n")
    entries.compact
    
    # Process the Data
    output = []
    entries.each do |entry|
      # Regexp for handling
      e = entry.match(/D(.*)\nT-?(.*)\nP(.*)\nN(.*)\nA(.*)\n/).to_a[1..-1]
      # Some files don't have lines with N or A, which messes things up
      e[1] = e[1].to_f rescue nil
      e[-1] = "\"#{e[-1]}\""
      output << "#{e.join(',')}\n"
    end
    # Write out the file
    File.open(output_filepath, "w+") do |f|
      output.each do |line|
        f.puts line
      end
    end
  end
  
end