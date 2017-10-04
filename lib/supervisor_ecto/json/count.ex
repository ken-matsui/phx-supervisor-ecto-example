defmodule SupervisorEcto.Json.Count do
  use Ecto.Schema
  import Ecto.Changeset
  alias SupervisorEcto.Json.Count


  schema "counts" do
    field :count, :integer

    timestamps()
  end

  @doc false
  def changeset(%Count{} = count, attrs) do
    count
    |> cast(attrs, [:count])
    |> validate_required([:count])
  end
end
