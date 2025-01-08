defmodule DemoWeb.MyComponentLive do
  use DemoWeb, :live_view

  alias DemoWeb.TestComponent

  def mount(_params, _session, socket) do

      dhello = [%{name: "jack", age: 12, address: "beijing"},
        %{name: "peter", age: 16, address: "newyork"},
        %{name: "jason", age: 14, address: "london"},
      ]
    {:ok, assign(socket, :dhello, dhello)}
  end
end
