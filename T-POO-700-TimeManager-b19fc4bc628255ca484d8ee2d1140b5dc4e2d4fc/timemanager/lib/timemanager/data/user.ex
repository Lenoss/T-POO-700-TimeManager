defmodule Timemanager.Data.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :address, :string
    field :city, :string
    field :country, :string
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string
    field :zipcode, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:address, :city, :country, :email, :firstname, :lastname, :role, :zipcode])
    |> validate_required([:address, :city, :country, :email, :firstname, :lastname, :role, :zipcode])
  end
end
