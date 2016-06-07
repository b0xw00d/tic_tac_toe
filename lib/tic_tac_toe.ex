defmodule TicTacToe do

  @markers [:x, :o]

  defmodule Board do
    defstruct cells: Enum.map(1..9, &(&1 = nil)), current_turn: 0
  end

  def take_turn(board, position) do
    board.cells
    |> Enum.at(position)
    |> case do
      nil -> {:ok, place_marker(board, position)}
      _taken -> {:error, "cell is already taken"}
    end
  end

  def game_over?(board) do
    horizontal_win(board) || vertical_win(board) || diagonal_win(board)
  end

  defp place_marker(board, position) do
    %Board{
      board |
      cells: List.replace_at(board.cells, position, marker(board.current_turn)),
      current_turn: +1
    }
  end

  defp horizontal_win(board) do
    board.cells
    |> Enum.chunk(3)
    |> Enum.any? fn(row) ->
      Enum.all?(row, &(&1 == :x)) || Enum.all?(row, &(&1 == :o))
    end
  end

  defp vertical_win(board) do
    transpose(board)
    |> Enum.any? fn(column) ->
      Enum.all?(column, &(&1 == :x)) || Enum.all?(column, &(&1 == :o))
    end
  end

  defp diagonal_win(board) do
    left_to_right_diagonal_win(board) || right_to_left_diagonal_win(board)
  end

  defp transpose(board) do
    board.cells
    |> Enum.chunk(3)
    |> List.zip
    |> Enum.map &(Tuple.to_list(&1))
  end

  defp left_to_right_diagonal_win(board) do
    diagonal = Enum.map [0,4,8], fn(cell_index) ->
      Enum.at(board.cells, cell_index)
    end
    Enum.all?(diagonal, &(&1 == :x)) || Enum.all?(diagonal, &(&1 == :o))
  end

  defp right_to_left_diagonal_win(board) do
    diagonal = Enum.map [2,4,6], fn(cell_index) ->
      Enum.at(board.cells, cell_index)
    end
    Enum.all?(diagonal, &(&1 == :x)) || Enum.all?(diagonal, &(&1 == :o))
  end

  defp marker(current_turn) when rem(current_turn, 2) == 0 do
    @markers |> List.first
  end

  defp marker(_), do: @markers |> List.last

end
