defmodule Felix.Application do
  @moduledoc false

  use Application

  alias Felix.{Config, Router}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      Plug.Adapters.Cowboy.child_spec(
        :http, Router, [], [port: Config.port]
      )
    ]

    opts = [strategy: :one_for_one, name: Felix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
