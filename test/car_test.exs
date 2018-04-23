defmodule CarTest do
  use ExUnit.Case
  doctest Car



  test "2 robots one way" do
    pid = Car.AgentCar.place()
    Car.AgentCar.move(pid)

    position =  Car.AgentCar.report(pid)
    assert position == {0, 1, :north}



    pid1 = Car.AgentCar.place()
    Car.AgentCar.move(pid1)
    Car.AgentCar.move(pid1)

    position1 =  Car.AgentCar.report(pid1)
    assert position1 == {0, 2, :north}

  end




  test "rotates the robot to the right" do
    {:ok, robot} = Car.place(0, 0, :north)
    position = robot |> Car.right |> Car.report
    assert position == {0, 0, :east}

    position = robot |> Car.right |> Car.right |> Car.report
    assert position == {0, 0, :south}
  end

  test "rotates the robot to the left" do
    {:ok, robot} = Car.place(0, 0, :north)
    position = robot |> Car.left |> Car.report

    assert position == {0, 0, :west}
  end

  test "rotating the robot 3 times to the right is the same as rotate its to the left" do
    {:ok, robot} = Car.place(0, 0, :north)
    right_position = robot |> Car.right |> Car.right |> Car.right |> Car.report
    left_position = robot |> Car.left |> Car.report

    assert right_position == left_position
  end

  test "moving robot up if it is facing to the north" do
    {:ok, robot} = Car.place(0, 0, :north)
    position = robot |> Car.move |> Car.report

    assert position == {0, 1, :north}
  end

  test "moving robot right if it is facing to the east" do
    {:ok, robot} = Car.place(0, 0, :east)
    position = robot |> Car.move |> Car.report

    assert position == {1, 0, :east}
  end

  test "moving robot down if it is facing to the south" do
    {:ok, robot} = Car.place(4, 4, :south)
    position = robot |> Car.move |> Car.report

    assert position == {4, 3, :south}
  end

  test "moving robot left if it is facing to the west" do
    {:ok, robot} = Car.place(4, 4, :west)
    position = robot |> Car.move |> Car.report

    assert position == {3, 4, :west}
  end

  test "prevent the robot to fall going north" do
    {:ok, robot} = Car.place(4, 4, :north)
    position = robot |> Car.move |> Car.report

    assert position == {4, 4, :north}
  end

  test "prevent the robot to fall going east" do
    {:ok, robot} = Car.place(4, 4, :east)
    position = robot |> Car.move |> Car.report

    assert position == {4, 4, :east}
  end

  test "prevent the robot to fall going south" do
    {:ok, robot} = Car.place(0, 0, :south)
    position = robot |> Car.move |> Car.report

    assert position == {0, 0, :south}
  end

  test "prevent the robot to fall going west" do
    {:ok, robot} = Car.place(0, 0, :west)
    position = robot |> Car.move |> Car.report

    assert position == {0, 0, :west}
  end
end
