IO.puts "Dynamic Supervisor Version:"
for _i <- 0..5 do
  name = Faker.Person.first_name()
  spawn(fn -> SlowGreeter.DynamicSupervisor.start_greeter(name) end)
end

IO.puts "Partition Supervisor Version:"
for _i <- 0..5 do
  name = Faker.Person.first_name()
  spawn(fn -> SlowGreeter.DynamicSupervisorWithPartition.start_greeter(name) end)
end
