defmodule DemoWeb.ServersLiveTest do
  use DemoWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "clicking a server link shows its details", %{conn: conn} do
    first = create_server("First")
    second = create_server("Second")

    {:ok, view, _html} = live(conn, "/servers")

    assert has_element?(view, "nav", first.name)
    assert has_element?(view, "nav", second.name)
    assert has_element?(view, "#selected-server", first.name)

    view
    |> element("#ss", second.name)
    |> render_click()

    assert has_element?(view, "#selected-server", second.name)
    assert_patched(view, "/servers?id=#{second.id}")
  end

  test "selects the server identified in the URL", %{conn: conn} do

    _first = create_server("First")
    second = create_server("Second")

    {:ok, view, _html} = live(conn, "/servers?id=#{second.id}")

    assert has_element?(view, "#selected-server", second.name)

  end

  defp create_server(name) do
    {:ok, server} =
      Demo.Servers.create_server(%{
        name: name,
        status: "up",
        git_repo: "repo",
        size: 1.0
      })

    server
  end
end
