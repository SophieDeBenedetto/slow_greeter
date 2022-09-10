defmodule SlowGreeter.DynamicSupervisorWithPartition do
  use DynamicSupervisor
  alias SlowGreeter.Worker

  def start_link(init_arg) do
    DynamicSupervisor.start_link(__MODULE__, init_arg, name: __MODULE__)
  end

  @impl true
  def init(_init_arg) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_greeter(name) do
    spec = %{id: Worker, start: {Worker, :start_link, [%{name: name, from: "PartitionSupervisor"}]}}

    DynamicSupervisor.start_child(
      {:via, PartitionSupervisor, {__MODULE__, self()}},
      spec
    )
  end
end
