defmodule SlowGreeter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do

    # Partition Supervisor Version
    children = [
      {PartitionSupervisor, child_spec: DynamicSupervisor, name: SlowGreeter.DynamicSupervisorWithPartition},
      {DynamicSupervisor, name: SlowGreeter.DynamicSupervisor}
    ]

    opts = [strategy: :one_for_one, name: SlowGreeter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
