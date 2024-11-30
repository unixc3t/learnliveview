defmodule Demo.VolunteersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.Volunteers` context.
  """

  @doc """
  Generate a volunteer.
  """
  def volunteer_fixture(attrs \\ %{}) do
    {:ok, volunteer} =
      attrs
      |> Enum.into(%{
        check_out: true,
        name: "some name",
        phone: "some phone"
      })
      |> Demo.Volunteers.create_volunteer()

    volunteer
  end
end
