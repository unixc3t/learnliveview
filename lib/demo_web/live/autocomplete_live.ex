defmodule DemoWeb.AutocompleteLive do
alias Demo.Cities
  use DemoWeb, :live_view

  alias Demo.Stores


  def mount(_params, _session, socket) do
    socket = assign(socket, zip: "", stores: [], loading: false, city: "", matches: [])
    {:ok, socket}
  end

  def handle_event("zip-search", %{"zip" => zip}, socket) do
     send(self(), {:run_zip_search, zip})
    socket = assign(socket, zip: zip, stores: [], loading: true)
    {:noreply, socket}
  end

  def handle_event("city-search", %{"city" => city}, socket) do
     send(self(), {:run_city_search, city})
    socket = assign(socket, city: city, stores: [], loading: true)
    {:noreply, socket}
  end

  def handle_event("suggest-city", %{"city" => prefix}, socket) do
    socket = assign(socket, matches: Cities.suggest(prefix))
    {:noreply, socket}
  end

  def handle_info({:run_zip_search, zip}, socket) do
    case Stores.search_by_zip(zip) do
      [] ->
        socket =
          socket
          |> put_flash(:info, "No stores matching \"#{zip}\"")
          |> assign(stores: [], loading: false)

        {:noreply, socket}

      stores ->
        socket =
          socket
          |> clear_flash()
          |> assign(stores: stores, loading: false)

        {:noreply, socket}
    end
  end

  def handle_info({:run_city_search, city}, socket) do
    stores = Stores.search_by_city(city)

    socket =
      case stores do
        [] -> put_flash(socket, :info, "No stores matching \"#{city}\"")
        _ -> clear_flash(socket)
      end

    socket = assign(socket, stores: stores, loading: false)
    {:noreply, socket}
  end
end
