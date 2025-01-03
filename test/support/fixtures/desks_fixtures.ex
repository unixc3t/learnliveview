defmodule Demo.DesksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.Desks` context.
  """

  @doc """
  Generate a desk.
  """
  def desk_fixture(attrs \\ %{}) do
    {:ok, desk} =
      attrs
      |> Enum.into(%{
        name: "some name",
        photo_urls: ["option1", "option2"]
      })
      |> Demo.Desks.create_desk()

    desk
  end
end
