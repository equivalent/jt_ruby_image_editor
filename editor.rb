#! ruby ``
Dir['./lib/**/*.rb'].each {|file| require file }

def parse_input(string)
 string.strip! #trim white spaces including \n
 command_array = string.split(' ')
 command = command_array.reverse!.pop
 command_array.reverse!
 return command.to_s, command_array
end

def editor_klass
  Editor
end


while(user_input = gets) do
  command, arguments = parse_input(user_input)
  begin
    case command
      when ""
        #do nothing
      when 'I' 
        # I M N. Create a new M x N image with all pixels colured white (O)
        @editor = editor_klass.new(arguments[0].to_i, arguments[1].to_i)
      when 'C'
        #C. Clears the table, stetting all pixels to white (O)
        @editor.clear
      when 'L'
        #L X Y C. Colours the pixel (X,Y) with colour C.
        @editor.paint_pixel(arguments[0].to_i, arguments[1].to_i, arguments[2])
      when 'V'
       # V X Y1 Y2 C. Draw a vertical segment of colour C in column X between rows Y1 and Y2
        #@editor.line_vertical(arguments[0].to_i, arguments[1].to_i, arguments[2].to_i, arguments[3])
      when 'H'
        #H X1 X2 Y C. Draw a horizontal segment of colour C in row Y between columns X1 and X2
        @editor.line_horizontal(arguments[0].to_i, arguments[1].to_i, arguments[2].to_i, arguments[3])
      when 'F'
        #F  X Y C. Fill the region R with the colour C.  R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs qto this region
      when 'S'
        # S. Show the contents of the current imag
        @editor.show
      when 'X'
        exit
      else 
        print "Unknown command"
    end
  rescue Exception => e
    # Catching and printing instance exception, so the program won't fail
    puts "ERROR: #{e.message}"
  end

  print "\n"
end
