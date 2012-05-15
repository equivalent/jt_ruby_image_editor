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
  case command
    when ""
    when 'I' 
      # I M N. Create a new M x N image with all pixels colured white (O)
      editor_klass.new(arguments[0], arguments[1])
    when 'C'
      #C. Clears the table, stetting all pixels to white (O)
    when 'I'
      #L X Y C. Colours the pixel (X,Y) with colour C.
    when 'V'
     # V X Y1 Y2 C. Draw a vertical segment of colour C in column X between rows Y1 and Y2
    when 'H'
      #H X1 X2 Y C. Draw a horizontal segment of colour C in row Y between columns X1 and X2
    when 'H'
      #F  X Y C. Fill the region R with the colour C.  R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs qto this region
    when 'S'
      # S. Show the contents of the current imag
    when 'X'
      exit
    else 
      print "Unknown command"
  end

  print "\n"
end
