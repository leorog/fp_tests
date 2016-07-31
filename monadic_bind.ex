defmodule MonadicBind do

  def run(something) do
    something.()
    |> bind
    |> do_something_else
    |> do_a_third_thing
  end

  def bind(x), do: if is_integer(x), do: {:some, x}, else: :none

  def do_something_else(:none), do: :none
  def do_something_else({:some, x}), do: {:some, x * x}

  def do_a_third_thing(:none), do: :none
  def do_a_third_thing({:some, x}), do: {:some, 1..10 |> Enum.map(&(&1 * x))}

  def run(something, [fun1, fun2, fun3]) do
    something.()
    |> bind
    |> bind_f(fun1)
    |> bind_f(fun2)
    |> bind_f(fun3)
  end

  def bind_f(:none, _), do: :none
  def bind_f({:some, x}, f), do: {:some, f.(x)}

end

MonadicBind.run(fn -> 4 end) |> IO.inspect
MonadicBind.run(fn -> nil end) |> IO.inspect

MonadicBind.run(fn -> 2 end, [&(&1 * 2), &(&1 + &1), &(&1 * &1)]) |> IO.inspect
MonadicBind.run(fn -> nil end, [&(&1 * 2), &(&1 + &1), &(&1/2)]) |> IO.inspect
