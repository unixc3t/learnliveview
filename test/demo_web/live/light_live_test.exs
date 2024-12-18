defmodule DemoWeb.LightLiveTest do
  use DemoWeb.ConnCase, async: true
  import Phoenix.LiveViewTest
  #use Gettext, backend: Demo.Gettext

  test "init render", %{conn: conn} do
    conn = get(conn, "/light")
    {:ok, view, html} = live(conn)
    assert html =~ "Porch Light"
    assert render(view) =~ "Porch Light"
  end

  test "light controls", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/light")

    assert render(view) =~ "10"
    assert view |> element("button", "up") |> render_click() =~ "20"
    assert view |> element("button", "down") |> render_click() =~ "10"
    assert view |> element("button", "on") |> render_click() =~ "100"
    assert view |> element("button", "off") |> render_click() =~ "0"
    refute render(view) =~ "100%"
  end
end
