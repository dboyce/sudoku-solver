class Player
  move: (n)->
    n = @lookahead unless n?
    bestMove = null
    for piece in @board.getPieces(@colour)
      x = piece.x
      y = piece.y
      for v in piece.vectors
        cell = @board.getCell(x + v.x, y + v.y)
        if(cell and not cell.piece? or cell.piece? and not cell.piece.colour == @colour)
          score = if cell.piece? 100 else 0
          mandatory = cell.piece?
          if(n > 0) # can we look ahead?

            # push move
            oldCell = piece.cell
            capturedPiece = oldCell.piece
            piece.moveTo(cell)
            @colour = @colour.opposite

            # swap sides and pick best move
            score = score + move(n)

            #pop move
            piece.moveTo(oldCell)
            oldCell.piece = capturedPiece

          bestMove = move if not bestMove? or mandatory and not bestMove.mandatory or score > bestMove.score

    bestMove # if null, couldn't move any pieces?


