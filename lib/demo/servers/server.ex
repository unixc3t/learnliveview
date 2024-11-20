defmodule Demo.Servers.Server do
  use Ecto.Schema
  import Ecto.Changeset

  schema "servers" do
    field :name, :string
    field :size, :float
    field :status, :string
    field :git_repo, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(server, attrs) do
    server
    |> cast(attrs, [:name, :status, :size, :git_repo])
    |> validate_required([:name, :status, :size, :git_repo])
  end
end
