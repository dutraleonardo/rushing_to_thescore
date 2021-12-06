defmodule RushingToThescore.PlayerRepo do
  import Ecto.Query, warn: false

  alias RushingToThescore.Repo
  alias RushingToThescore.Player

  @spec list(maybe_improper_list) :: any
  @doc """
  Returns a list of players based on a `filter`.

  Example filter:

  [
    filter: %{player: "Joe"},
    sorting: %{sort_by: :item, sort_order: :asc},
  ]
  """
  def list(filter) when is_list(filter) do
    require IEx
    IEx.pry()

    from(d in Player)
    |> filter_generator(filter)
    |> Repo.all()
  end

  def insert_entries_from_file(file) do
    {:ok, rushing_stats} = RushingToThescore.Helpers.FileImporter.json_importer(file)

    Enum.each(rushing_stats, fn rushing_stat ->
      RushingToThescore.Player.changeset(%RushingToThescore.Player{}, rushing_stat)
      |> RushingToThescore.Repo.insert!()
    end)
  end

  def list_group_by do
    from(p in Player,
      group_by: p.team,
      order_by: [desc: sum(p.yds)],
      select: %{
        Team: p.team,
        Yds: sum(p.yds),
        Lng: fragment("max(replace(?, 'T', '')::integer)", p.lng)
      }
    )
    |> Repo.all()
  end

  defp filter_generator(query, clause) when is_list(clause) do
    Enum.reduce(clause, query, fn
      {:filter, %{player: player_name}}, query ->
        from q in query, where: like(q.player, ^"%#{player_name}%")

      {:sorting, %{sort_by: sort_by, sort_order: sort_order}}, query ->
        from q in query, order_by: [{^sort_order, ^sort_by}]
    end)
  end
end
