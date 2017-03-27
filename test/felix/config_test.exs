defmodule Felix.ConfigTest do
  use ExUnit.Case, async: true

  alias Felix.Config

  setup do
    on_exit fn ->
      System.delete_env("PORT")
    end

    :ok
  end

  test "retrieve port number" do
    assert Config.port(:test) == 4001
    assert Config.port(:dev) == 4000
    assert Config.port(:prod) == 4000
  end

  test "retrieve port number with given PORT env variable" do
    System.put_env("PORT", "8080")

    assert Config.port(:test) == 4001
    assert Config.port(:dev) == 8080
    assert Config.port(:prod) == 8080
  end
end
