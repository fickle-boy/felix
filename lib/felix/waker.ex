defmodule Felix.Waker do
  @moduledoc false

  use GenServer

  # Client Functions

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def count do
    GenServer.call(__MODULE__, :count)
  end

  # Callback Definitions

  def init(:ok) do
    Process.send(self(), :trigger, [])

    {:ok, 0}
  end

  def handle_call(:count, _from, state) do
    {:reply, state, state}
  end

  def handle_info(:trigger, state) do
    urls = Application.get_env(:felix, :urls)
    Enum.each urls, fn(url) ->
      Task.start fn ->
        url
        |> to_char_list()
        |> :httpc.request
      end
    end

    Process.send_after(self(), :trigger, 20 * 60 * 1_000)

    {:noreply, state + 1}
  end
end
