defmodule Felix.OMGPriceReporter do
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
    info = @url
           |> HTTPoison.get!()
           |> Map.get(:body)
           |> Poison.decode!()
           |> Map.get("26")
    message = """
    ```
    ----- #{info["secondary_currency"]} -----
    Last price: #{info["last_price"]}
    Change: #{info["change"]}
    ```
    """
    Slack.Web.Chat.post_message("#omg", message)
  end

  defp schedule_work do
    Process.send_after(self(), :notify, @interval)
  end
end
