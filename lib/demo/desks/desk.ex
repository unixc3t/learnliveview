defmodule Demo.Desks.Desk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "desks" do
    field :name, :string
    field :photo_urls, {:array, :string}, default: []

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(desk, attrs) do
    desk
    |> cast(attrs, [:name, :photo_urls])
    |> validate_required([:name, :photo_urls])
  end
end
