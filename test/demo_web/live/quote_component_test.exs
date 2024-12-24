defmodule DemoWeb.Live.QuoteComponentTest do
  use DemoWeb.ConnCase, async: true
  import Phoenix.LiveViewTest

  alias DemoWeb.QuoteComponent

  test "renders quote with 24-hour expiry by default" do
    assigns = [
      id: "quote",
      weight: 2.0,
      price: 4.0,
      material: "sand"
    ]

    html = render_component(QuoteComponent, assigns)

    assert html =~ "2.0 pounds of sand"
    assert html =~ "expires in 24 hours"
  end
end
