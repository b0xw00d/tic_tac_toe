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

      fact "it errors when the cell is already occupied", %{board: board} do
        TicTacToe.take_turn(board, 0) |> equals {:error, "cell is already taken"}
      end

      fact "it counts the number of turns", %{board: board} do
        board.current_turn |> equals 1
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

      fact "it finds diagonal wins from the left" do
        diagonal = %TicTacToe.Board{
          cells: [:x, nil, nil, nil, :x, nil, nil, nil, :x]
        }
        TicTacToe.game_over?(diagonal) |> equals true
      end

      fact "it finds diagonal wins from the right" do
        diagonal = %TicTacToe.Board{
          cells: [nil, nil, :o, nil, :o, nil, :o, nil, nil]
        }
        TicTacToe.game_over?(diagonal) |> equals true
      end

      fact "it rejects diagonal ties" do
        diagonal = %TicTacToe.Board{
          cells: [:x, nil, nil, nil, :o, nil, nil, nil, :x]
        }
        TicTacToe.game_over?(diagonal) |> equals false
      end
    end

  end
end
