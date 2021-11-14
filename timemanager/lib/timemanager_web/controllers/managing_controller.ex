defmodule TimemanagerWeb.ManagingController do
  use TimemanagerWeb, :controller

  alias Timemanager.Data
  alias Timemanager.Data.Managing

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    managing = Data.list_managing()
    render(conn, "index.json", managing: managing)
  end

  def create(conn, %{"managing" => managing_params}) do
    with {:ok, %Managing{} = managing} <- Data.create_managing(managing_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.managing_path(conn, :show, managing))
      |> render("show.json", managing: managing)
    end
  end

  def show(conn, %{"userID" => id}) do
    managing = Data.get_managing!(id)
    render(conn, "index.json", managing: managing)
  end

  def show_team(conn, %{"teamId" => teamId}) do
    managing = Data.list_managing_team(teamId)
    render(conn, "index.json", managing: managing)
  end

  def update(conn, %{"id" => id, "managing" => managing_params}) do
    managing = Data.get_managing!(id)

    with {:ok, %Managing{} = managing} <- Data.update_managing(managing, managing_params) do
      render(conn, "show.json", managing: managing)
    end
  end

  def delete(conn, %{"id" => id}) do
    managing = Data.get_managing!(id)

    with {:ok, %Managing{}} <- Data.delete_managing(managing) do
      send_resp(conn, :no_content, "")
    end
  end
end
