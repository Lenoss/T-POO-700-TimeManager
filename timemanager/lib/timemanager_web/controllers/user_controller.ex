defmodule TimemanagerWeb.UserController do
  use TimemanagerWeb, :controller

  alias Timemanager.Data
  alias Timemanager.Data.User
  alias Timemanager.Guardian
  action_fallback TimemanagerWeb.FallbackController

  def sign_in(conn, %{"email" => email, "password" => password}) do
    case Data.authenticate_user(email, password) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, %{})

        conn
        |> Guardian.Plug.sign_in(user)
        |> render("jwt.json", %{jwt: jwt, user: user})

      _ ->
        {:error, :unauthorized}
    end
  end

  def index(conn, _params) do
    users = Data.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Data.create_user(user_params),
         {:ok, jwt, _claims} <- Guardian.encode_and_sign(user) do
      conn |> render("jwt.json", %{jwt: jwt, user: user})
    end
  end

  def show(conn, %{"userID" => id}) do
    user = Data.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"userID" => id, "user" => user_params}) do
    user = Data.get_user!(id)

    with {:ok, %User{} = user} <- Data.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"userID" => id}) do
    user = Data.get_user!(id)

    with {:ok, %User{}} <- Data.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
