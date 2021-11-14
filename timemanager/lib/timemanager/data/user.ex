defmodule Timemanager.Data.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  import Ecto.Changeset
  import Bcrypt

  schema "users" do
    field :address, :string
    field :city, :string
    field :country, :string
    field :email, :string
    field :firstname, :string
    field :lastname, :string
    field :role, :string
    field :zipcode, :string
    field :password_hash, :string

    field :password, :string, virtual: true


    timestamps()
  end

  def changeset_role(user_or_changeset, attrs) do
    user_or_changeset
    |> Changeset.cast(attrs, [:role])
    |> Changeset.validate_inclusion(:role, ~w(Member GeneralManager))
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :address,
      :city,
      :country,
      :email,
      :firstname,
      :lastname,
      :role,
      :zipcode,
      :password
    ])
    |> validate_required([
      :address,
      :city,
      :country,
      :email,
      :firstname,
      :lastname,
      :role,
      :zipcode
    ])
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, hash_pwd_salt(pass))

      _ ->
        changeset
    end
  end
end
