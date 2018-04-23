defmodule Car.AgentCar do
  def place do
    {:ok, state} = Car.place
    {:ok, pid} = Agent.start_link(fn -> state end)
    pid
  end

  def move(pid), do: Agent.update(pid, &(Car.move(&1)))

  def left(pid), do: Agent.update(pid, &(Car.left(&1)))

  def right(pid), do: Agent.update(pid, &(Car.right(&1)))

  def report(pid) do
    Agent.get(pid, &(&1))
    |> Car.report
  end
end
