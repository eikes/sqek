namespace :user do

  desc "Create a new user"
  task create: :environment do
    puts "Enter an email address:"
    email = STDIN.gets.strip!
    puts "Enter a password:"
    system "stty -echo"
    password = STDIN.gets.strip!
    system "stty echo"
    puts "Select role: 1 = admin, 2 = user"
    role = STDIN.gets.strip!
    unless email.blank? || password.blank?
      if User.create!(email: email, password: password, role: (role == "1" ? "admin" : "user"))
        puts "The user was created successfully!"
      else
        puts "Sorry, the user was not created!"
      end
    end
  end

  desc "Delete a user"
  task delete: :environment do
    puts "You will be prompted to enter an email address for the user"
    puts "Enter an email address:"
    email = STDIN.gets
    unless email.strip!.blank?
      User.find_by_email(email).try(:destroy!)
    end
  end

end
