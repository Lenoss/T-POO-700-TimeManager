defmodule Timemanager.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :address, :string
      add :city, :string
      add :country, :string
      add :email, :string
      add :firstname, :string
      add :lastname, :string
      add :role, :string
      add :zipcode, :string
      add :password_hash, :string

      timestamps()
    end
  end
end
