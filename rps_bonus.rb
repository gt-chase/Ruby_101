VALID_CHOICES = ['r', 'p', 's', 'l', 'c']

winner = { 'r' => ['s', 'l'],
           'l' => ['c', 'p'],
           'c' => ['s', 'r'],
           's' => ['p', 'l'],
           'p' => ['r', 'c'] }

def value_extract(status_check, input)
  status_check.fetch(input)
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

user_tally = 0
computer_tally = 0

instructions = <<-HII
Welcome to Rock Paper Scissors Spock Lizard

To make it easy, type:
r for Rock
p for Paper
s for scissors
c for Spock (That's Commander Spock to you)
l for Lizard
Not sure on the rules? Either look them up or just start playing!
You'll figure it out.
HII

puts prompt(instructions)

loop do # main loop
  choice = ''
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    else
      prompt("That is not a valid choice")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  if value_extract(winner, choice).include?(computer_choice)
    user_tally += 1
    prompt("You win this round!")
  elsif value_extract(winner, computer_choice).include?(choice)
    computer_tally += 1
    prompt("Computer wins this round")
  else
    prompt("This round is a tie")
  end

  if user_tally == 3
    puts "YOU WON THREE ROUNDS FIRST!
    The computer's win count was: #{computer_tally}"
  elsif computer_tally == 3
    puts "THE COMPUTER WON THREE ROUNDS FIRST.
    Your win count was: #{user_tally}"
    user_tally = 0 && computer_tally = 0
  else next
  end

  prompt("Do you want to play again? Type 'yes' to play again.")
  answer = Kernel.gets().chomp()
  if answer.downcase != 'yes'
    break
  end
end # main loop
