defmodule Demo.Repo.Migrations.CreatePizzaorders do
  use Ecto.Migration

  def change do
    create table(:pizzaorders) do
      add :pizza, :string
      add :username, :string

      timestamps(type: :utc_datetime)
    end
  end
end
