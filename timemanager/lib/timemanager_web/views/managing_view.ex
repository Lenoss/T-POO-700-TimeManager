defmodule TimemanagerWeb.ManagingView do
  use TimemanagerWeb, :view
  alias TimemanagerWeb.ManagingView

  def render("index.json", %{managing: managing}) do
    %{data: render_many(managing, ManagingView, "managing.json")}
  end

  def render("show.json", %{managing: managing}) do
    %{data: render_one(managing, ManagingView, "managing.json")}
  end

  def render("managing.json", %{managing: managing}) do
    %{
      id: managing.id,
      isManager: managing.isManager,
      employeeId: managing.employeeId,
    }
  end
end
