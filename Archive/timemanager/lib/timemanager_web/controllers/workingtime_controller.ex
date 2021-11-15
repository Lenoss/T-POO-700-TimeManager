defmodule TimemanagerWeb.WorkingtimeController do
  use TimemanagerWeb, :controller

  alias Timemanager.Data
  alias Timemanager.Data.Workingtime

  action_fallback(TimemanagerWeb.FallbackController)

  def index(conn, _params) do
    workingtimes = Data.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"user_id" => user_id}) do
    params = Map.merge(%{"user" => user_id}, conn.body_params["workingtimes"])

    with {:ok, %Workingtime{} = workingtime} <- Data.create_workingtime(params) do
      conn
      |> put_status(:created)
      |> render("show.json", workingtime: workingtime)
    end
  end

  def show(conn, %{"user_id" => userID, "start" => start, "end" => ennd}) do
    user_id = String.to_integer(userID)

    workingtimes = Data.list_workingtimes_schedule(user_id, start, ennd)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def show(conn, %{"user_id" => user_id, "id" => id}) do
    workingtime = Data.list_workingtimes_by_user_and_id(user_id, id)
    render(conn, "index.json", workingtimes: workingtime)
  end

  def show(conn, %{"user_id" => user_id}) do
    workingtimes = Data.list_workingtimes_by_user(user_id)
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = Data.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <-
           Data.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = Data.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- Data.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end

  def options(conn, _, _) do
    send_resp(conn, 200, "Access-Control-Allow-Origin: *")
  end
end
