  #encoding UTF-8 for using russian letters with Windows

  if (Gem.win_platform?)
    #Encoding.default_external = Encoding.find(Encoding.locale_charmap)
    Encoding.default_internal = __ENCODING__

    [STDIN, STDOUT].each do |io|
      io.set_encoding(#Encoding.default_external,
                      Encoding.default_internal)
    end
  end

      require_relative 'book.rb'
      require_relative 'draft_book.rb'#
      require_relative 'fantasy.rb'
      require_relative 'detective.rb'
      require_relative 'humour.rb'
      require_relative 'fantasy_.rb'
      require_relative 'detective_.rb'
      require_relative 'humour_.rb'


  puts "Welcome to the Library. Used SQLite."

  # Механизм аутентификации
  # Зарегестрированный пользователь, пароль лежат в теле программы

  authorized_name = "1111"
  authorization_password = "1111"

  puts "Enter your name, please:"
  name = STDIN.gets.chomp
  puts "Enter your password, please:"
  password = STDIN.gets.chomp

  if authorized_name != name or authorization_password != password
    puts "You are not authorized: access forbidden"

  else
  # запись книги в общую библиотеку или в черновики?
      puts "Would you like to include your book in Common library? yes/no?"
      choicey = "no"
      user_choice = STDIN.gets.chomp
      if choicey != user_choice
          # запись книги в общую библиотеку

          puts "Which book would you add to the Common library?"


          choices = Book.post_types.keys
          choice = -1

          until choice>=0 && choice < (choices.size)

            choices.each_with_index do |type, index|
              puts "\t#{index}. #{type}"
            end
            choice = (STDIN.gets.chomp.to_i)
          end

          entry = Book.create(choices[choice])

          entry.read_from_console

          id = entry.save_to_db


          puts "Your book is saved in Common library. ID of your book = #{id}"
      else
        # запись книги в черновики?
      puts "Your book will be icluded in Draft library."
      #
      choices = Draftbook.post_types.keys
      choice = -1

      until choice>=0 && choice < (choices.size)

        choices.each_with_index do |type, index|
          puts "\t#{index}. #{type}"
        end
        choice = (STDIN.gets.chomp.to_i)
      end

      entry = Draftbook.create(choices[choice])

      entry.read_from_console

      id = entry.save_to_db

      puts "Your book is saved in Draft library. ID of your book = #{id}"

      end
  end