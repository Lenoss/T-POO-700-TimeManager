defmodule Timemanager.Data.Managing do
  use Ecto.Schema
  import Ecto.Changeset

  schema "managing" do
    field :isManager, :boolean, default: false
    field :teamId, :id
    field :employeeId, :id

    timestamps()
  end

  @doc false
  def changeset(managing, attrs) do
    managing
    |> cast(attrs, [:isManager])
    |> validate_required([:isManager])
  end
end
