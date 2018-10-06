defmodule Mapper.Repo.Migrations.CreatePlaces do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :name, :string
      add :lat, :float
      add :lng, :float
      add :address, :text

      timestamps()
    end

  end
end
