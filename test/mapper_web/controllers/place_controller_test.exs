defmodule MapperWeb.PlaceControllerTest do
  use MapperWeb.ConnCase

  alias Mapper.Listings

  @create_attrs %{address: "some address", lat: 120.5, lng: 120.5, name: "some name"}
  @update_attrs %{address: "some updated address", lat: 456.7, lng: 456.7, name: "some updated name"}
  @invalid_attrs %{address: nil, lat: nil, lng: nil, name: nil}

  def fixture(:place) do
    {:ok, place} = Listings.create_place(@create_attrs)
    place
  end

  describe "index" do
    test "lists all places", %{conn: conn} do
      conn = get conn, place_path(conn, :index)
      assert html_response(conn, 200) =~ "Listing Places"
    end
  end

  describe "new place" do
    test "renders form", %{conn: conn} do
      conn = get conn, place_path(conn, :new)
      assert html_response(conn, 200) =~ "New Place"
    end
  end

  describe "create place" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, place_path(conn, :create), place: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == place_path(conn, :show, id)

      conn = get conn, place_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Show Place"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, place_path(conn, :create), place: @invalid_attrs
      assert html_response(conn, 200) =~ "New Place"
    end
  end

  describe "edit place" do
    setup [:create_place]

    test "renders form for editing chosen place", %{conn: conn, place: place} do
      conn = get conn, place_path(conn, :edit, place)
      assert html_response(conn, 200) =~ "Edit Place"
    end
  end

  describe "update place" do
    setup [:create_place]

    test "redirects when data is valid", %{conn: conn, place: place} do
      conn = put conn, place_path(conn, :update, place), place: @update_attrs
      assert redirected_to(conn) == place_path(conn, :show, place)

      conn = get conn, place_path(conn, :show, place)
      assert html_response(conn, 200) =~ "some updated address"
    end

    test "renders errors when data is invalid", %{conn: conn, place: place} do
      conn = put conn, place_path(conn, :update, place), place: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Place"
    end
  end

  describe "delete place" do
    setup [:create_place]

    test "deletes chosen place", %{conn: conn, place: place} do
      conn = delete conn, place_path(conn, :delete, place)
      assert redirected_to(conn) == place_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, place_path(conn, :show, place)
      end
    end
  end

  defp create_place(_) do
    place = fixture(:place)
    {:ok, place: place}
  end
end
