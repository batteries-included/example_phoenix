defmodule ExampleUpgrade.Repo.Migrations.CreateClusters do
  use Ecto.Migration

  def change do
    create table(:clusters) do
      add :name, :string

      timestamps()
    end
  end
end
