defmodule TicTacToeTest do
  use Amrita.Sweet

  facts "TicTacToe" do

    facts "%Board" do
      setup do
        board = %TicTacToe.Board{}
        {:ok, default_board: board}
      end

      fact "starts with an empty board", %{default_board: default_board} do
        default_board.cells |> equals [nil, nil, nil, nil, nil, nil, nil, nil, nil]
      end

      fact "defaults to 0", %{default_board: default_board}  do
        default_board.current_turn |> equals 0
        default_board.current_turn |> !equals 1
      end
    end

    facts ".take_turn" do
      setup do
        default_board = %TicTacToe.Board{}
        {:ok, board} = TicTacToe.take_turn(default_board, 0)
        {:ok, board: board}
      end

      fact "places a marker", %{board: board} do
        board.cells |> equals [:x, nil, nil, nil, nil, nil, nil, nil, nil]
      end

      fact "allows players to take turns", %{board: board} do
        {:ok, turn_2} = TicTacToe.take_turn(board, 1)
        turn_2.cells |> equals [:x, :o, nil, nil, nil, nil, nil, nil, nil]
      end
    end

    facts ".game_over?" do
      fact "it returns false for boards without a win" do
        TicTacToe.game_over?(%TicTacToe.Board{}) |> equals false
      end

      fact "it finds horizontal wins" do
        horizontal = %TicTacToe.Board{
          cells: [:x, :x, :x, nil, nil, nil, nil, nil, nil]
        }
        TicTacToe.game_over?(horizontal) |> equals true
      end

      fact "it finds vertical wins" do
        vertical = %TicTacToe.Board{
          cells: [:x, nil, nil, :x, nil, nil, :x, nil, nil]
        }
        TicTacToe.game_over?(vertical) |> equals true
      end
    end

  end
end
