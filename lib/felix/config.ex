defmodule Felix.Config do
  @moduledoc false

  def port do
    (System.get_env("PORT") || "4000")
    |> String.to_integer
  end
end
