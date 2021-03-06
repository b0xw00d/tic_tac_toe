defmodule TicTacToe.Mixfile do
  use Mix.Project

  def project do
    [app: :tic_tac_toe,
     version: "0.0.1",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:amrita, "~>0.4", github: "josephwilk/amrita"}
    ]
  end
end
