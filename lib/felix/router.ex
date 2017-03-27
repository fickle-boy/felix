defmodule Felix.Router do
  @moduledoc false

  use Plug.Router

  alias Felix.Waker

  plug :match
  plug :dispatch

  get "/ping" do
    send_resp(conn, 200, "pong")
  end

  get "/count" do
    count = to_string(Waker.count)
    send_resp(conn, 200, count)
  end

  match _ do
    send_resp(conn, 404, "not found")
  end
end
