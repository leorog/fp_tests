defmodule Railway do

  def run(something) do
    something.()
    |> bind
    |> is_valid?
    |> is_available?
    |> from_maybe_and_print
  end

  def bind(x), do: if is_bitstring(x), do: {:some, x}, else: {:none, ["not a string"]}

  def is_valid?({:none, err}), do: {:none, ["skipping is_valid?. :none"] ++ err}
  def is_valid?({:some, "I'm invalid"}), do: {:none, ["invalid string"]}
  def is_valid?({:some, x}), do: {:some, x}

  def is_available?({:none, err}), do: {:none, ["skipping is_available?. :none"] ++ err}
  def is_available?({:some, x}) when x in ["abc", "cba", "123"], do: {:none, ["string unavailable"]}
  def is_available?({:some, x}), do: {:some, x}

  def from_maybe_and_print({:none, err}), do: err |> Enum.each(&IO.puts/1)
  def from_maybe_and_print({:some, x}), do: x |> IO.puts

end

IO.puts "==== input: Leo ===="
Railway.run(fn -> "Leo" end)
IO.puts "==== input: 5 ===="
Railway.run(fn -> 5 end)
IO.puts "==== input: abc ===="
Railway.run(fn -> "abc" end)
IO.puts "==== input: I'm invalid ===="
Railway.run(fn -> "I'm invalid" end)
