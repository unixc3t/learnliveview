defmodule DemoWeb.CreaturesComponent do
  use DemoWeb, :live_component

  def render(assigns) do
   ~H"""
        <div>
        <.modal id={@id}>
          a b  c d e f g
        <div>
          <button   phx-click={JS.exec("data-cancel", to: "##{@id}")}
          class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">
              close
          </button>
        </div>
        </.modal>
        </div>
   """
  end
end
