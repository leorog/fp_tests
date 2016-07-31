defmodule MonadicTaskBind do

  def run(something, [fun1, fun2, fun3]) do
    something.()
    |> to_some
    |> task_bind(fun1)
    |> task_bind(fun2)
    |> task_bind(fun3)
  end

  def to_some(x), do: if x |> is_integer, do: {:some, x}, else: :none

  def task_bind(:none, _), do: :none
  def task_bind({:some, nil}, _), do: :none
  def task_bind({:some, {:exit, _}}, _), do: :none
  def task_bind({:some, {:ok, x}}, f), do: {:some, x} |> task_bind(f)
  def task_bind({:some, x}, f), do: {:some, fn -> f.(x) end |> Task.async |> Task.yield}
end

MonadicTaskBind.run(fn -> 2 end, [&(&1 * 2), &(&1 + &1), &(&1 * &1)]) |> IO.inspect
MonadicTaskBind.run(fn -> nil end, [&(&1 * 2), &(&1 + &1), &(&1/2)]) |> IO.inspect
