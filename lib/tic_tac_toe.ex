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

  defp marker(current_turn) when rem(current_turn, 2) == 0 do
    @markers |> List.first
  end

  defp marker(current_turn), do: @markers |> List.last

end
