defmodule DemoWeb.FilterLiveTest do
  use DemoWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "filters boats by type and price", %{conn: conn} do
    fishing_1 = create_boat(model: "A", price: "$", type: "fishing")
    fishing_2 = create_boat(model: "B", price: "$$", type: "fishing")
    sporting_2 = create_boat(model: "C", price: "$$", type: "sporting")

    {:ok, view, _html} = live(conn, "/filter")

    assert has_element?(view, "div", fishing_1.model)
    assert has_element?(view, "div", fishing_2.model)
    assert has_element?(view, "div", sporting_2.model)

     view
       |> form("#change-filter")
       |> render_change(%{type: "fishing", prices: [""]})

    assert has_element?(view, "div", fishing_1.model)
    assert has_element?(view, "div", fishing_2.model)
    refute has_element?(view, "div", sporting_2.model)

  end


  def create_boat(attrs) do
    {:ok, boat} =
      attrs
      |> Enum.into(%{image: "image"})
      |> Demo.Boats.create_boat()

      boat
  end




end
