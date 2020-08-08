class SessionsController < ApplicationController


  def welcome
    @user = User.new
  end

  def create
    @client = Twilio::REST::Client.new account_sid, auth_token
    @user = User.new(user_params)
    @dice_roll = rand(10).to_i
    @message

    case @dice_roll
    when 0
      @message = "You woke up in a tavern. You got into a fight with an elf. Unfortunately you lost"
    when  1
      @message = "Oh no! A Dragon appeared! You raise your sword to fig...
      just kidding you are a coward and run and hide. You survive but the town does not. Time to go on a new adventure"
    when  2
      @message = "Hey you are finally awake. You are on a wagon with other prisoners. Looks like this will shape
      up to be a buggy adventure"
    when  3
      @message = "Oh no! An R.O.U.S. (Rodents of Unusual Size) just appeared! You use fire pits and make an escape"
    when  4
      @message = "You get out of bed and head to the local tavern to see if any quests are available. You see a brawl breaking out in the streets.
      You pull out your sword to see if you can bring order.....and you get hit by an arrow and die."
    when  5
      @message = "Someone screams for your help. Since you are a #{@user.rpg_class} you use all of your might to slay the dragon.
      The town is safe but no one seems to care that you are a hero. "
    when  6
      @message = "He screams at you to cast the object in your hand into the fire. You begin to but then you think...why should I?
      You pocket it. It whispers to you to throw him instead. You are now the dark lord of the realm"
    when 7
      @message = "A dragon appears out of no where you take a sip from the flask at your side and will yourself to fight.
      You are victorious! The king grants you your deepest desires."
    when  8
      @message = "You find a random bag of gold on the ground which just happens to be exactly enough to live the rest of your life comfortably.
      You don't have to go on a quest"
    when  9
      @message = "Thank you for your help but the princess is in another castle."
    when  10
      @message = "You rekindled the fire. The age of man will continue bearer of the curse"
    else
      @message = "You died"
    end

    puts "Test #{@user.name} #{@user.phone_number} #{@user.rpg_class}"
    send_text(@user.phone_number, "Hello #{@user.name} You are a #{@user.rpg_class},
      You rolled a #{@dice_roll}
      Welcome to SMS Land. Your miniature quest is #{@message}"
    )
    render :welcome
  end

  private

 #adds strong params <- Don't forget this again....for real
 def send_text(number, message)
   @client.api.account.messages.create(
     to: number,
     from: 'add phone number',
     body: message
   )
 end


  def user_params
    params.require(:user).permit(:name, :phone_number, :rpg_class)
  end

  def account_sid
    @account_sid = "add key"
  end

  def auth_token
    @auth_token = "add key"
  end

end
