defmodule Demo.ServersFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Demo.Servers` context.
  """

  @doc """
  Generate a server.
  """
  def server_fixture(attrs \\ %{}) do
    {:ok, server} =
      attrs
      |> Enum.into(%{
        git_repo: "some git_repo",
        name: "some name",
        size: 120.5,
        status: "some status"
      })
      |> Demo.Servers.create_server()

    server
  end
end
