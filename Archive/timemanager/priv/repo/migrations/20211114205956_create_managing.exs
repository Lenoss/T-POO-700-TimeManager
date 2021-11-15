defmodule Timemanager.Repo.Migrations.CreateManaging do
  use Ecto.Migration

  def change do
    create table(:managing) do
      add :isManager, :boolean, default: false, null: false
      add :teamId, references(:teams, on_delete: :nothing)
      add :employeeId, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:managing, [:teamId])
    create index(:managing, [:employeeId])
  end
end
