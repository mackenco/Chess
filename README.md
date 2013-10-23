#Chess

A command-line, two-player chess game built in Ruby. Features: 
 * Standard chess gameplay, including alerting for check and checkmate, castling, and pawn promotion.
 * Prevents movement of a piece if it would lead to check.
 * Allows users to save or load a previous game state using YAML serialization.
 * Utilizes module inheritance to reduce code (e.g. bishop and queen inherit from the same movement logic).
