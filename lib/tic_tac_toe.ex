defmodule TicTacToe do

  @markers [:x, :o]

  defmodule Board do
    defstruct cells: Enum.map(1..9, &(&1 = nil)), current_turn: 0
  end

  def take_turn(board, position) do
    new_board = %Board{
      board |
      current_turn: +1,
      cells: List.replace_at(board.cells, position, marker(board.current_turn))
    }
    {:ok, new_board}
  end

  def game_over?(board) do
    horizontal_win(board) || vertical_win(board) || diagonal_win(board)
  end

  defp transpose(board) do
    Enum.chunk(board.cells, 3)
    |> List.zip
    |> Enum.map fn(x) -> Tuple.to_list(x) end
  end

  defp left_to_right_diagonal_win(board) do
    diagonal = Enum.map([0,4,8], fn(x) -> Enum.at(board.cells, x) end)
    Enum.all?(diagonal, &(&1 == :x)) || Enum.all?(diagonal, &(&1 == :o))
  end

  defp right_to_left_diagonal_win(board) do
    diagonal = Enum.map([2,4,6], fn(x) -> Enum.at(board.cells, x) end)
    Enum.all?(diagonal, &(&1 == :x)) || Enum.all?(diagonal, &(&1 == :o))
  end

  defp diagonal_win(board) do
    left_to_right_diagonal_win(board) || right_to_left_diagonal_win(board)
  end

  defp horizontal_win(board) do
    Enum.chunk(board.cells, 3) |> Enum.any? fn(x) ->
      Enum.all?(x, &(&1 == :x)) || Enum.all?(x, &(&1 == :o))
    end
  end

  defp vertical_win(board) do
    transpose(board) |> Enum.any? fn(x) ->
      Enum.all?(x, &(&1 == :x)) || Enum.all?(x, &(&1 == :o))
    end
  end

  defp marker(current_turn) when rem(current_turn, 2) == 0 do
    @markers |> List.first
  end

  defp marker(_), do: @markers |> List.last

end
