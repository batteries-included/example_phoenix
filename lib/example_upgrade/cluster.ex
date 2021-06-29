defmodule ExampleUpgrade.Cluster do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clusters" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(cluster, attrs) do
    cluster
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def validate(params) do
    changeset =
      %ExampleUpgrade.Cluster{}
      |> changeset(params)
      |> Map.put(:action, :validate)

    data =
      changeset
      |> Ecto.Changeset.apply_changes()

    {changeset, data}
  end
end
