defmodule Demo.PizzaOrdersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.PizzaOrders` context.
  """

  @doc """
  Generate a pizza_order.
  """
  def pizza_order_fixture(attrs \\ %{}) do
    {:ok, pizza_order} =
      attrs
      |> Enum.into(%{
        pizza: "some pizza",
        username: "some username"
      })
      |> Demo.PizzaOrders.create_pizza_order()

    pizza_order
  end
end
