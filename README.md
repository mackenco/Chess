#Chess

A command-line, two-player chess game built in Ruby. Features: 
 * Standard chess gameplay, including alerting for check and checkmate, castling, and pawn promotion
 * Prevents movement of a piece if it would lead to check
 * Allows users to save or load a previous game state using YAML serialization
 * Uses modules to reduce code, allowing pieces with similar movement to inherit the same movement logic
