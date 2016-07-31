defmodule HollywoodPrinciple do

  def divide_pm(top, 0), do: IO.puts "Cannot divide by 0!"
  def divide_pm(top, bottom), do: div(top, bottom)

  def divide_three(iferror, top, bottom) do
    if bottom == 0, do: iferror.(), else: div(top, bottom)
  end

  def divide_four(iferror, ifsuccess, top, bottom) do
    if bottom == 0, do: iferror.(), else: ifsuccess.(top,bottom)
  end

end

iferror = fn -> IO.puts "handling some error..." end
ifsuccess = fn(x,y) -> IO.puts "result is #{div(x,y)}" end

IO.puts "three to two"
divide = fn(x,y) -> HollywoodPrinciple.divide_three(iferror, x, y) end
divide.(2,2) |> IO.puts
divide.(2,0)

IO.puts "\nfour to two"
divide = fn(x,y) -> HollywoodPrinciple.divide_four(iferror, ifsuccess, x, y) end
divide.(2,2)
divide.(2,0)
