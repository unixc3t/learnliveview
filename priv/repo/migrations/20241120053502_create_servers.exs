defmodule Demo.Repo.Migrations.CreateServers do
  use Ecto.Migration

  def change do
    create table(:servers) do
      add :name, :string
      add :status, :string
      add :size, :float
      add :git_repo, :string

      timestamps(type: :utc_datetime)
    end
  end
end
