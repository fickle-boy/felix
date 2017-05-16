defmodule Felix.Router do
  @moduledoc false

  use Plug.Router

  alias Felix.{Myself, Waker}

  plug :match
  plug :dispatch

  get "/ping" do
    send_resp(conn, 200, "pong")
  end

  get "/count" do
    count = to_string(Waker.count)
    send_resp(conn, 200, count)
  end

  get "/my_info" do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Poison.encode!(Myself.info))
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
