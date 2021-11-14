defmodule TimemanagerWeb.UserControllerTest do
  use TimemanagerWeb.ConnCase

  import Timemanager.DataFixtures

  alias Timemanager.Data.User

  @create_attrs %{
    address: "some address",
    city: "some city",
    country: "some country",
    email: "some email",
    firstname: "some firstname",
    lastname: "some lastname",
    role: "some role",
    zipcode: "some zipcode"
  }
  @update_attrs %{
    address: "some updated address",
    city: "some updated city",
    country: "some updated country",
    email: "some updated email",
    firstname: "some updated firstname",
    lastname: "some updated lastname",
    role: "some updated role",
    zipcode: "some updated zipcode"
  }
  @invalid_attrs %{address: nil, city: nil, country: nil, email: nil, firstname: nil, lastname: nil, role: nil, zipcode: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some address",
               "city" => "some city",
               "country" => "some country",
               "email" => "some email",
               "firstname" => "some firstname",
               "lastname" => "some lastname",
               "role" => "some role",
               "zipcode" => "some zipcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.user_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "some updated address",
               "city" => "some updated city",
               "country" => "some updated country",
               "email" => "some updated email",
               "firstname" => "some updated firstname",
               "lastname" => "some updated lastname",
               "role" => "some updated role",
               "zipcode" => "some updated zipcode"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, Routes.user_path(conn, :update, user), user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, Routes.user_path(conn, :delete, user))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.user_path(conn, :show, user))
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
