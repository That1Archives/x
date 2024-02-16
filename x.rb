class MyLanguageInterpreter
    def initialize
      @variables = {}
    end
  
    def interpret(line)
      tokens = line.split(' ')
      case tokens[0]
      when 'ADD'
        puts tokens[1].to_i + tokens[2].to_i
      when 'SUBTRACT'
        puts tokens[1].to_i - tokens[2].to_i
      when 'MULTIPLY'
        puts tokens[1].to_i * tokens[2].to_i
      when 'DIVIDE'
        puts tokens[1].to_i / tokens[2].to_i
      when 'MODULOS'
        puts tokens[1].to_i % tokens[2].to_i
      when 'PRINT'
        print_tokens = tokens[1..-1].map { |token| @variables[token] || token }
      puts print_tokens.join(' ')
      when 'VAR'
        variable_name = tokens[1]
        value = tokens[3..-1]
        if tokens[2] == '='
          @variables[variable_name] = value
        else
          puts "TYPE_ERROR: To identify/reference a variable, please place '=' before assigning value\nX_ERROR_CODE: 'TYPE_ERROR'"
        end
      when 'GET'
        variable_name = tokens[1]
        if @variables.key?(variable_name)
          puts @variables[variable_name]
        else
          puts "REFERENCE_ERROR: Could not find #{variable_name}, please check for spelling mistakes"
        end
      when 'DEF'
        function_name = tokens[1]
        @function_stack.push(function_name)
      when 'END'
        expected_function_name = @function_stack.pop
        actual_function_name = tokens[1]
        if expected_function_name != actual_function_name
          raise "Unexpected 'END' for function '#{actual_function_name}'. Expected 'END' for function '#{expected_function_name}'."
        end
      else
        puts "Unknown command"
      end
    end
  
    def interpret_file(file_path)
      File.foreach(file_path) do |line|
        interpret(line.chomp)
      end
    end
  end
  
  interpreter = MyLanguageInterpreter.new
  
  # Check if a file with .x extension is provided as an argument
  if ARGV.length == 1 && File.extname(ARGV[0]) == ".x"
    interpreter.interpret_file(ARGV[0])
  else
    puts "x <file name>.x"
  end
  