# Roll-a-Dice

Roll-a-dice is simple multiplayer game build using flutter and firebase.
in this game player can press "Roll a dice" button and game provide user a Random result anywhere between 1 and 6, the player gets 10 chances to play, and every time the result of the dice roll is added to the Player's score and saved to the database.

# Pattern
Roll-a-Dice is build using BloC pattern where each business logic is kept saperated from the UI part. This game uses StreamBuilder and Provider as it neeeded.

# Storage
Score and attempts are stored offline as well as online on Firebase's realtime database. Local storage is created using shared_preferences where current score and number of attempts are stored to let user to play game in offline mode.

# authentication
Roll-a-Dice uses GoogleSignin method using firebase authentication which ease user to get in the game without worrying about the registration process

# modes
This game is compatible with debug as well as release mode for flutter code only

# other feature
Game contains leaderboard option where they can get to know their postion globally.
