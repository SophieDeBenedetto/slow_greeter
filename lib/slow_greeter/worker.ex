defmodule SlowGreeter.Worker do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, name)
  end

  def init(name) do
    :timer.sleep(10000)
    send(self(), :greet)
    {:ok, name}
  end

  def handle_info(:greet, name) do
    IO.puts("Hello, #{name}")
    {:noreply, name}
  end
end
