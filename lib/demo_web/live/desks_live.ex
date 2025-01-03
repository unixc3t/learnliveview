defmodule DemoWeb.DesksLive do
  use DemoWeb, :live_view

  alias Demo.Desks
  alias Demo.Desks.Desk


  def mount(_params, _session, socket) do
    if connected?(socket), do: Desks.subscribe()

    desks = Desks.list_desks()
    changeset = Desks.change_desk(%Desk{})

    socket =
      assign(socket,
      form: to_form(changeset) )

    socket = allow_upload(
      socket,
      :photo,
      accept: ~w(.png .jpeg .jpg),
      max_entries: 3,
      max_file_size: 10_000_000
    )

    #socket  = stream_configure(socket, :songs, dom_id: &("desks-#{&1.id}"))

    {:ok, stream(socket, :desks, desks)}
  end

  def upload_error_to_string(:too_many_files), do: "selected too many files"
  def upload_error_to_string(:too_large), do: "The file is too large"
  def upload_error_to_string(:not_accepted), do: "You have selected an unacceptable file type"
  def upload_error_to_string(:external_client_failure), do: "Something went terribly wrong"


  def handle_event("save", %{"desk" => params}, socket) do


    {completed, []} = uploaded_entries(socket, :photo)
    urls = for entry <- completed do
      ~p"/uploads/#{filename(entry)}"
    end

    desk = %Desk{photo_urls: urls}

    case Desks.create_desk(desk, params, &consume_photos(socket, &1)) do
      {:ok, desk} ->
        send(self(), {:desk_created, desk})
        changeset = Desks.change_desk(%Desk{})
        socket = assign(socket, form: to_form(changeset))
        {:noreply, socket}

      {:error, %Ecto.Changeset{} = changeset} ->
        socket = assign(socket, form: to_form(changeset))
        {:noreply, socket}
    end
  end

  def handle_event("cancel-upload", %{"ref" => ref}, socket) do
    {:noreply, cancel_upload(socket, :photo, ref)}
  end

   def handle_event("validate", %{"desk" => params}, socket) do
    changeset =
      %Desk{}
      |> Desks.change_desk(params)
      |> Map.put(:action, :insert)

    socket =
      assign(socket,
        form: to_form(changeset)
      )

    {:noreply, socket}
  end

  def consume_photos(socket, desk) do
    consume_uploaded_entries(socket, :photo, fn meta, entry ->
      dest = Path.join("priv/static/uploads", filename(entry))
      File.cp!(meta.path, dest)
      {:ok, ~p"/uploads/#{filename(entry)}"}
    end)
    {:ok, desk}
  end

  def handle_info({:desk_created, new_desk}, socket) do
    #socket = update(socket, :volunteers, fn volunteers -> [volunteer | volunteers] end)
    {:noreply, stream(socket, :desks, [new_desk], at: 0 )}
    #{:noreply, stream(socket, :desks, [new_desk])}
  end

  defp filename(entry) do
    [ext | _ ] = MIME.extensions(entry.client_type)
    "#{entry.uuid}.#{ext}"
  end

end
