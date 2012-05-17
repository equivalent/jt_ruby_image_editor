class Interface
  def initialize
    while(user_input = gets) do
      command, arguments = parse_input(user_input)
      begin
        case command
          when ""
            #do nothing
          when 'I' 
            @editor = editor_klass.new(*arguments.collect(&:to_i))
          when 'C'
            @editor.clear
          when 'L'
            @editor.paint_pixel(*arguments[0..1].collect(&:to_i), arguments[2])
          when 'V'
            @editor.line_vertical(*arguments[0..2].collect(&:to_i), arguments[3])
          when 'H'
            @editor.line_horizontal(*arguments[0..2].collect(&:to_i), arguments[3])
          when 'F'
            @editor.fill(*arguments[0..1].collect(&:to_i), arguments[2])
          when 'S'
            @editor.show
          when 'X'
            exit
          when 'help'
            puts "#{printf("%-12s",'I M N.')} Create a new M x N image with all pixels colured white (O)"

            puts "#{printf("%-12s",'C.')} Clears the table, stetting all pixels to white (O)"

            puts "#{printf("%-12s",'L X Y C.')} Colours the pixel (X,Y) with colour C."
            puts "#{printf("%-12s",'V X Y1 Y2 C.')} Draw a vertical segment of colour C in column X between rows Y1 and Y2"
            puts "#{printf("%-12s",'H X1 X2 Y C.')} Draw a horizontal segment of colour C in row Y between columns X1 and X2"
            puts "#{printf("%-12s",'F X Y C.')} Fill the region R with the colour C.  R is defined as: Pixel (X,Y) belongs to R. Any other pixel which is the same colour as (X,Y) and shares a common side with any pixel in R also belongs qto this region"
            puts "#{printf("%-12s",'S.')} Show the contents of the current imag"
            puts "#{printf("%-12s",'X.')} For terminating the program"
          else 
            puts "Unknown command"
        end
      rescue NoMethodError
        puts "Wrong argument or the image isn't initialized"
        puts 'For more info run command "help"'
      rescue SystemExit
        exit
      rescue Exception => e
        # Catching and printing instance exception, so the program won't fail
        puts "ERROR: #{e.message}"
        puts 'For more info run command "help"'
      end

      print "\n"
    end
  end

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
end
