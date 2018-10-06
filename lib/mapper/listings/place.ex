defmodule Mapper.Listings.Place do
  use Ecto.Schema
  import Ecto.Changeset


  schema "places" do
    field :address, :string
    field :lat, :float
    field :lng, :float
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(place, attrs) do
    place
    |> cast(attrs, [:name, :lat, :lng, :address])
    |> validate_required([:name, :lat, :lng, :address])
  end
end
