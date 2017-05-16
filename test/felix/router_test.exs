defmodule Felix.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Felix.Router

  @opts Router.init([])

  test "get /ping" do
    conn = :get |> conn("/ping") |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong"
  end

  test "get invalid paths" do
    Enum.each ["/", "missing"], fn(path) ->
      conn = :get |> conn(path) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 404
      assert conn.resp_body == "not found"
    end
  end

  test "get /my_info" do
    conn = :get |> conn("/my_info") |> Router.call(@opts)
    body = conn.resp_body |> Poison.decode!

    assert conn.state == :sent
    assert conn.status == 200
    assert body["first_name"] == "Teerawat"
    assert body["last_name"] == "Lamanchart"
    assert "Elixir" in body["skills"]
  end
end
