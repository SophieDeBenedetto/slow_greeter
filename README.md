# SlowGreeter

A sample app to demonstrate Elixir v1.14's new [`PartitionSupervisor`](https://hexdocs.pm/elixir/main/PartitionSupervisor.html). To run the demo:

## Demo

To see the difference between using a regular `DynamicSupervisor` and using a `PartitionSupervisor`:

* Open up an IEx session:

```
iex -S mix
```

* Run this sample code to execute 5 concurrent calls to the `DynamicSupervisor`

```elixir
for _i <- 1..5 do
  name = Faker.Person.first_name()
  # The DynamicSupervisor starts a worker that sleeps for 5 seconds then puts a greeting
  spawn(fn -> SlowGreeter.DynamicSupervisor.start_greeter(name) end)
end
```

You'll see that each call happened synchronously--the same `DynamicSupervisor` was being asked to start a child worker by five different processes at the same time. So each process had to wait its turn. You'll see five greetings printed out one at a time, at five second intervals.

* Run this sample code to execute 5 concurrent calls to the `PartitionSupervisor`:

```elixir
for _i <- 1..5 do
  name = Faker.Person.first_name()
  # The PartitionSupervisor tells one of its DynamicSuprevisors to start a worker that sleeps for 5 seconds then puts a greeting
  spawn(fn -> SlowGreeter.DynamicSupervisorWithPartition.start_greeter(name) end)
end
```

You'll see that all five calls to the `DynamicSupervisor` to start a greeting worker happened more or less concurrently. The `PartitionSupervisor` distributed the requests from each of the five spawned processes to the `DynamicSupervisor`s it started up when the app started up. You'll see that after just one five second sleep, all five greeting print out simultaneously.
