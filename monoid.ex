# monoid structure
list = 1..100
|> Enum.map( &([qty: :random.uniform(&1), price: :random.uniform(10_000) * 0.01]) )

add_pair = fn(x, acc) ->
  [qty: x[:qty] + acc[:qty], price: x[:price] + acc[:price]]
end

list
|> Enum.reduce(add_pair)
|> IO.inspect

# functions can be monoid too
multiply_by_two = fn(x) -> x*2 end
divide_by_four = fn(x) -> div(x,4) end

multiply_by_two_and_divide_by_four = fn(x) -> x |> multiply_by_two.() |> divide_by_four.() end

10..20
|> Enum.map(multiply_by_two_and_divide_by_four)
|> IO.inspect
