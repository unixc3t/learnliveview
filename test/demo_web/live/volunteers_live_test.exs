defmodule DemoWeb.VolunteersLiveTest do
  use DemoWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  test "adds valid volunteer to list", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/volunteers")

    valid_attrs = %{name: "New Volunteer", phone: "303-555-1212"}

    view
    |> form("#create-volunteer", %{volunteer: valid_attrs })
    |> render_submit()

    assert has_element?(view, "#volunteer-list", valid_attrs.name)
  end

  test "displays live validations", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/volunteers")

    invalid_attrs = %{name: "New Volunteer", phone: ""}

    view
    |> form("#create-volunteer", %{volunteer: invalid_attrs })
    |> render_change()

    assert has_element?(view, "#create-volunteer", "can't be blank")
  end

  test "clicking status button toggles status", %{conn: conn} do
    _volunteer = create_volunteer()

    {:ok, view, _html} = live(conn, "/volunteers")

    status_button = "#toggle-button"

    view
    |> element(status_button, "Check Out")
    |> render_click()

    assert has_element?(view, status_button, "Check In")
  end

  test "receives real-time updates", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/volunteers")

    external_volunteer = create_volunteer()

    assert has_element?(view, "#volunteer-list", external_volunteer.name)

  end


  defp create_volunteer() do
    {:ok, volunteer} =
      Demo.Volunteers.create_volunteer(%{
        name: "New Volunteer",
        phone: "303-555-1212"
      })

      volunteer
  end
end
