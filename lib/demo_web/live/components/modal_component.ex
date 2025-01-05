defmodule DemoWeb.ModalComponent do
  use DemoWeb, :live_component
  def render(assigns) do
    ~H"""

      <div id="underwater">
        <.live_component  id={@id} module={DemoWeb.CreaturesComponent} />
      </div>
    """
  end
end
