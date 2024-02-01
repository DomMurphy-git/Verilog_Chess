# EC311_Project
## Project Name: _Something easy to remember_
## Team Members: 
Leonardo Mattos Martins <br>Dominic Murphy <br>Astrid Mihalopoulos <br>Rohan Alexander <br>
## Link to your Project Demo Video: https://youtu.be/TrAUt3saXr8 <br>
## Overview of the Project: 
We implemented a chess program using custom graphics on a VGA display and button inputs. The program uses patterns in between moves and the basic starting position of the chess board to describe and restrict the movement of every piece without the use of Block RAM or any kind of memory to store these combinations. Each piece has its own custom sprite, and they can even follow the more specialized rules such as promoting a pawn to queen when on the last row of the board, both short and long castling, and en passant. Further logic has also been written to prevent moves which would cause a check to occur, and all other win conditions such as stalemate or checkmate.                           
<br>
## How to run your project: <br>
Download the Zip File and Extract -> Create a New Project in Vivado 2022.2 -> Open Project Directory -> Program BitStream to Digilent Nexys A7-100T FPGA Trainer Board (Or an FPGA of your choice by editing the constraint file) -> Plug into a VGA -> Find a friend and play!
## Overview of the code structure (what code does what): <br>
![Alt text](ChessFlow.png)
## Anything else you feel is relevant: 
### checkDistance debugging visualization:
![Alt text](checkDistance_Debugger.jpeg)
### How to play chess: _Extract from [Chess.com](https://www.chess.com/learn-how-to-play-chess)_
At the beginning of the game the chessboard is laid out so that each player has the white (or light) color square in the bottom right-hand side.<br><br>

The chess pieces are then arranged the same way each time. The second row (or rank) is filled with pawns. The rooks go in the corners, then the knights next to them, followed by the bishops, and finally the queen, who always goes on her own matching color (white queen on white, black queen on black), and the king on the remaining square.<br><br>

Each of the 6 different kinds of pieces moves differently. Pieces cannot move through other pieces (though the knight can jump over other pieces), and can never move onto a square with one of their own pieces. However, they can be moved to take the place of an opponent's piece which is then captured. Pieces are generally moved into positions where they can capture other pieces (by landing on their square and then replacing them), defend their own pieces in case of capture, or control important squares in the game.<br><br>

How to Move the King in Chess<br>
The king is the most important piece, but is one of the weakest. The king can only move one square in any direction - up, down, to the sides, and diagonally.<br><br>

The king may never move himself into check (where he could be captured). When the king is attacked by another piece this is called "check".<br><br>

How To Move The Queen In Chess<br>
The queen is the most powerful piece. She can move in any one straight direction - forward, backward, sideways, or diagonally - as far as possible as long as she does not move through any of her own pieces.<br><br>

And, like with all pieces, if the queen captures an opponent's piece her move is over. Notice how the white queen captures the black queen and then the black king is forced to move.<br><br>

How To Move The Rook In Chess<br>
The rook may move as far as it wants, but only forward, backward, and to the sides.<br><br>

The rooks are particularly powerful pieces when they are protecting each other and working together!<br><br>

How To Move The Bishop In Chess<br>
The bishop may move as far as it wants, but only diagonally. Each bishop starts on one color (light or dark) and must always stay on that color.<br><br>

Bishops work well together because they cover up each other's weaknesses.<br><br>

How To Move The Knight In Chess<br>
Knights move in a very different way from the other pieces – going two squares in one direction, and then one more move at a 90-degree angle, just like the shape of an “L”.<br><br>

Knights are also the only pieces that can move over other pieces.<br><br>

How To Move The Pawn In Chess<br>
Pawns are unusual because they move and capture in different ways: they move forward but capture diagonally. Pawns can only move forward one square at a time, except for their very first move where they can move forward two squares.<br><br>

Pawns can only capture one square diagonally in front of them. They can never move or capture backward. If there is another piece directly in front of a pawn he cannot move past or capture that piece.<br><br>

There are a few special rules in chess that may not seem logical at first. They were created to make the game more fun and interesting.<br><br>

How To Promote A Pawn In Chess<br>
Pawns have another special ability and that is that if a pawn reaches the other side of the board it can become any other chess piece (called promotion) excluding a king (or pawn, for that matter).<br><br>

A pawn may be promoted to a knight, bishop, rook, or queen. A common misconception is that pawns may only be exchanged for a piece that has been captured. That is NOT true. A pawn is usually promoted to a queen. Only pawns may be promoted.<br><br>

How to promote a pawn in chess<br><br>

How To Do "En Passant" In Chess<br>
The last rule about pawns is called “en passant,” which is French for “in passing”. If a pawn moves out two squares on its first move, and by doing so lands to the side of an opponent's pawn (effectively jumping past the other pawn's ability to capture it), that other pawn has the option of capturing the first pawn as it passes by.<br><br>

Chess en passant<br>
This special move must be done immediately after the first pawn has moved past, otherwise the option to capture it is no longer available. Click through the example below to better understand this odd, but important rule.<br><br>

How To Castle In Chess<br>
One other special chess rule is called castling. This move allows you to do two important things all in one move: get your king to safety (hopefully), and get your rook out of the corner and into the game. On a player's turn he may move his king two squares over to one side and then move the rook from that side's corner to right next to the king on the opposite side. (See the example below.) However, in order to castle, the following conditions must be met:<br><br>

it must be that king's very first move<br>
it must be that rook's very first move<br>
there cannot be any pieces between the king and rook to move<br>
the king may not be in check or pass through check<br><br>

Notice that when you castle one direction the king is closer to the side of the board. That is called castling "kingside". Castling to the other side, through where the queen sat, is called castling "queenside". Regardless of which side, the king always moves only two squares when castling.<br><br>

How to castle in chess<br><br>

The player with the white pieces always moves first. Therefore, players generally decide who will get to be white by chance or luck such as flipping a coin or having one player guess the color of the hidden pawn in the other player's hand. White then makes a move, followed by black, then white again, then black, and so on until the end of the game. Being able to move first is a tiny advantage that gives the white player an opportunity to attack right away.<br><br>

There are several ways to end a game of chess: by checkmate, with a draw, by resignation, by forfeit on time...<br><br>

How To Checkmate In Chess<br><br>

The purpose of the game is to checkmate the opponent's king. This happens when the king is put into check and cannot get out of check.<br><br>

There are only three ways a king can get out of check:<br><br>

move out of the way (though he cannot castle!)<br>
block the check with another piece or<br>
capture the piece threatening the king.<br>

If a king cannot escape checkmate then the game is over. Customarily the king is not captured or removed from the board, the game is simply declared over.<br><br>

Checkmate can happen in the early stages of the game if one of the players does not act carefully. Below, you will find an example of the Fools mate, a checkmate that happens in just 2 moves. <br><br>

How To Draw A Chess Game<br><br>

Occasionally chess games do not end with a winner, but with a draw. There are 5 reasons why a chess game may end in a draw:<br><br>

The position reaches a stalemate where it is one player's turn to move, but his king is NOT in check and yet he does not have another legal move:
Chess Stalemate<br><br>

With the move Qc7, black is not threatened and can't move. The game is declared a draw by stalemate. <br><br>

The players may simply agree to a draw and stop playing <br>
There are not enough pieces on the board to force a checkmate (example: a king and a bishop vs. a king)<br>
A player declares a draw if the same exact position is repeated three times (though not necessarily three times in a row)<br>
Fifty consecutive moves have been played where neither player has moved a pawn or captured a piece<br>

There are four simple things that every chess player should know:<br><br>

Protect Your King<br>
Get your king to the corner of the board where he is usually safer. Don't put off castling. You should usually castle as quickly as possible. Remember, it doesn't matter how close you are to checkmating your opponent if your own king is checkmated first!<br><br>

Don't Give Pieces Away<br>
Don't carelessly lose your pieces! Each piece is valuable and you can't win a game without pieces to checkmate. There is an easy system that most players use to keep track of the relative value of each chess piece. How much are the chess pieces worth?<br>

A pawn is worth 1<br>
A knight is worth 3<br>
A bishop is worth 3<br>
A rook is worth 5<br>
A queen is worth 9<br>
The king is infinitely valuable<br>

At the end of the game, these points don't mean anything—it is simply a system you can use to make decisions while playing, helping you know when to capture, exchange, or make other moves.<br><br>

Control The Center Of The Chessboard<br>
You should try and control the center of the board with your pieces and pawns. If you control the center, you will have more room to move your pieces and will make it harder for your opponent to find good squares for his pieces. In the example above white makes good moves to control the center while black plays bad moves.<br><br>

Use All Of Your Chess Pieces<br>
In the example above white got all of his pieces in the game! Your pieces don't do any good when they are sitting back on the first row. Try and develop all of your pieces so that you have more to use when you attack the king. Using one or two pieces to attack will not work against any decent opponent.<br><br>
