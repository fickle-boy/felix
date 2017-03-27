defmodule Felix.Config do
  @moduledoc false

  def port(:test),
    do: 4001
  def port(_),
    do: (System.get_env("PORT") || "4000") |> String.to_integer
end
