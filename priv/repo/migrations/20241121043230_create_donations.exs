defmodule Demo.Repo.Migrations.CreateDonations do
  use Ecto.Migration

  def change do
    create table(:donations) do
      add :emoji, :string
      add :item, :string
      add :quantity, :integer
      add :days_until_expires, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
