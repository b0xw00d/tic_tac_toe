defmodule TicTacToeTest do
  use Amrita.Sweet

  facts "TicTacToe" do

    facts "%Board" do
      setup do
        board = %TicTacToe.Board{}
        {:ok, board: board}
      end

      fact "starts with an empty board", %{board: board} do
        board.cells |> equals [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      end

      fact "defaults to 0", %{board: board}  do
        board.current_turn |> equals 0
        board.current_turn |> !equals 1
      end
    end

    facts ".take_turn" do
      setup do
        board = %TicTacToe.Board{}
        {:ok, turn} = TicTacToe.take_turn(board, 0)
        {:ok, turn: turn}
      end

      fact "places a marker", %{turn: turn} do
        turn.cells |> equals [:x, nil, nil, nil, nil, nil, nil, nil, nil]
      end

      fact "allows players to take turns", %{turn: turn} do
        {:ok, turn_2} = TicTacToe.take_turn(turn, 1)
        turn_2.cells |> equals [:x, :o, nil, nil, nil, nil, nil, nil, nil]
      end
    end

    facts ".game_over?" do
      
    end

  end
end
