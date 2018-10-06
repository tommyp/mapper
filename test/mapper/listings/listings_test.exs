defmodule Mapper.ListingsTest do
  use Mapper.DataCase

  alias Mapper.Listings

  describe "places" do
    alias Mapper.Listings.Place

    @valid_attrs %{address: "some address", lat: 120.5, lng: 120.5, name: "some name"}
    @update_attrs %{address: "some updated address", lat: 456.7, lng: 456.7, name: "some updated name"}
    @invalid_attrs %{address: nil, lat: nil, lng: nil, name: nil}

    def place_fixture(attrs \\ %{}) do
      {:ok, place} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Listings.create_place()

      place
    end

    test "list_places/0 returns all places" do
      place = place_fixture()
      assert Listings.list_places() == [place]
    end

    test "get_place!/1 returns the place with given id" do
      place = place_fixture()
      assert Listings.get_place!(place.id) == place
    end

    test "create_place/1 with valid data creates a place" do
      assert {:ok, %Place{} = place} = Listings.create_place(@valid_attrs)
      assert place.address == "some address"
      assert place.lat == 120.5
      assert place.lng == 120.5
      assert place.name == "some name"
    end

    test "create_place/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Listings.create_place(@invalid_attrs)
    end

    test "update_place/2 with valid data updates the place" do
      place = place_fixture()
      assert {:ok, place} = Listings.update_place(place, @update_attrs)
      assert %Place{} = place
      assert place.address == "some updated address"
      assert place.lat == 456.7
      assert place.lng == 456.7
      assert place.name == "some updated name"
    end

    test "update_place/2 with invalid data returns error changeset" do
      place = place_fixture()
      assert {:error, %Ecto.Changeset{}} = Listings.update_place(place, @invalid_attrs)
      assert place == Listings.get_place!(place.id)
    end

    test "delete_place/1 deletes the place" do
      place = place_fixture()
      assert {:ok, %Place{}} = Listings.delete_place(place)
      assert_raise Ecto.NoResultsError, fn -> Listings.get_place!(place.id) end
    end

    test "change_place/1 returns a place changeset" do
      place = place_fixture()
      assert %Ecto.Changeset{} = Listings.change_place(place)
    end
  end
end
