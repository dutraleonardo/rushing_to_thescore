defmodule RushingToThescore.Player do
  use Ecto.Schema
  import Ecto.Changeset

  schema "players" do
    field :att, :float
    field :att_g, :float
    field :avg, :float
    field :first_down, :float
    field :first_down_porcent, :float
    field :forty_plus, :float
    field :fum, :float
    field :lng, :string
    field :player, :string
    field :pos, :string
    field :td, :float
    field :team, :string
    field :twenty_plus, :float
    field :yds, :float
    field :yds_g, :float

    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{:__changeset__ => map, optional(any) => any}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  @doc false
  def changeset(player, attrs) do
    player
    |> cast(attrs, [
      :player,
      :team,
      :pos,
      :att,
      :att_g,
      :yds,
      :avg,
      :yds_g,
      :td,
      :lng,
      :first_down,
      :first_down_porcent,
      :twenty_plus,
      :forty_plus,
      :fum
    ])
    |> validate_required([
      :player,
      :team,
      :pos,
      :att,
      :att_g,
      :yds,
      :avg,
      :yds_g,
      :td,
      :lng,
      :first_down,
      :first_down_porcent,
      :twenty_plus,
      :forty_plus,
      :fum
    ])
  end
end
