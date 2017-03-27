defmodule Felix.RouterTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Felix.Router

  @opts Router.init([])

  test "get /ping" do
    conn = conn(:get, "/ping") |> Router.call(@opts)

    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body == "pong"
  end

  test "get invalid paths" do
    Enum.each ["/", "missing"], fn(path) ->
      conn = conn(:get, path) |> Router.call(@opts)

      assert conn.state == :sent
      assert conn.status == 404
      assert conn.resp_body == "not found"
    end
  end
end
