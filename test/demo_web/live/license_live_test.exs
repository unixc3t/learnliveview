defmodule DemoWeb.LicenseLiveTest do
  use DemoWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "updating number of seats changes seats and amount", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/license")

    #rendered = render(view)

    #assert rendered =~ "2"
    #assert rendered =~ "$40.00"

    assert has_element?(view, "#seats", "2")
    assert has_element?(view, "#amount", "$40.00")

      view
      |> form("#update-seats", %{seats: 3})
      |> render_change()

    assert has_element?(view, "#seats", "3")
    assert has_element?(view, "#amount", "$60.00")
  end
end
