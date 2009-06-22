class Converter
  
  def self.translate(input_filepath, output_filepath, options = {})
    # Read the input
    file = File.read(input_filepath)
    file.gsub!("\r\n", "\n") # Remove windows newline characters, for comformity of processing files
    file.gsub!(/\!(.*)\n/, "") # Remove the Info line
    
    entries = file.split("^\n")
    entries.compact
    
    # Process the Data
    output = []
    entries.each do |entry|
      # Regexp for handling
      e = entry.match(/D(.*)\nT-?(.*)\nP(.*)\n(N(.*)\n)?(A(.*)\n)?/).to_a[1..-1] # The dash after "D" is optional, the N, and A lines are also optional
      next if e.nil? # Skip if there's no match (could be caused by extra newlines)
      e[1] = e[1].to_f rescue nil
      e[-1] = "\"#{e[-1]}\"" if e[-1] # Quote descriptions
      newline_char = options[:windows_format] ? "\r\n" : "\n"
      output << "#{e.join(',')}#{newline_char}"
    end
    # Write out the file
    File.open(output_filepath, "w+") do |f|
      output.each do |line|
        f.puts line
      end
    end
  end
  
end