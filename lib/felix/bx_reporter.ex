defmodule Felix.BXReporter do
  use GenServer

  @interval :timer.minutes(10)
  @url "https://bx.in.th/api/"

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Process.send(self(), :notify, [])

    {:ok, []}
  end

  def handle_info(:notify, state) do
    notify()
    schedule_work()
    {:noreply, state}
  end

  defp notify do
    pairings =
      @url
      |> HTTPoison.get!()
      |> Map.get(:body)
      |> Poison.decode!()

    omg = Map.get(pairings, "26")
    eth = Map.get(pairings, "21")
    xrp = Map.get(pairings, "25")

    message = Enum.reduce [omg, eth, xrp], "", fn(info, acc) ->
      acc <> """
      ```
      ----- #{info["secondary_currency"]} -----
      Last price: #{info["last_price"]}
      Change: #{info["change"]}
      ```
      """
    end

    Slack.Web.Chat.post_message("#omg", message)
  end

  defp schedule_work do
    Process.send_after(self(), :notify, @interval)
  end
end
