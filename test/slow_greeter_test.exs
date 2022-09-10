defmodule SlowGreeterTest do
  use ExUnit.Case
  doctest SlowGreeter

  test "greets the world" do
    assert SlowGreeter.hello() == :world
  end
end
