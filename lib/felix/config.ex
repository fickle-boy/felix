defmodule Felix.Config do
  @moduledoc false

  def port(:test),
    do: 4001
  def port(_),
    do: String.to_integer(System.get_env("PORT") || "4000")
end
