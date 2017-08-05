defmodule Felix.Application do
  @moduledoc false

  use Application

  alias Felix.{Router, Waker, OMGPriceReporter}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = Application.get_env(:felix, :port)
    children = [
      Plug.Adapters.Cowboy.child_spec(
        :http, Router, [], [port: port]
      ),
      worker(Waker, []),
      worker(OMGPriceReporter, []),
    ]

    opts = [strategy: :one_for_one, name: Felix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
