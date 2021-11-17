defmodule TimemanagerWeb.ClockController do
  use TimemanagerWeb, :controller

  alias Timemanager.Data
  alias Timemanager.Data.Clock

  action_fallback TimemanagerWeb.FallbackController

  def index(conn, _params) do
    clocks = Data.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  def create(conn, _params) do
    with {:ok, %Clock{} = _params} <-
      Data.create_clock(%{
        time: _params["clocks"]["time"],
        status: _params["clocks"]["status"],
        user: _params["userID"]

  })
     do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.clock_path(conn, :show, _params))
      |> render("show.json", clock: _params)
    end
  end

  def show(conn, %{"id" => id}) do
    clock = Data.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = Data.get_clock!(id)

    with {:ok, %Clock{} = clock} <- Data.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = Data.get_clock!(id)

    with {:ok, %Clock{}} <- Data.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
