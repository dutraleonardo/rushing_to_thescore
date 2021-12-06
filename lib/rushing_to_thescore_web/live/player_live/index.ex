defmodule RushingToThescoreWeb.PlayerLive.Index do
  use RushingToThescoreWeb, :live_view

  alias RushingToThescore.Player

  @impl true
  def mount(_params, _session, socket) do
    players_stats = RushingToThescore.Repo.all(Player)
    {:ok, assign(socket, query: "", stats: players_stats)}
  end

  @impl true
  def handle_event("filter", %{"filter" => filter} = _, socket) do
    filtered_players_stats = require IEx
    IEx.pry()

    [filter: %{player: filter}]
    |> RushingToThescore.PlayerRepo.list()

    require IEx
    IEx.pry()
    {:noreply, assign(socket, query: filter, stats: filtered_players_stats)}
  end

  @impl true
  def handle_params(%{"sort_by" => field, "filter" => filter}, _, socket) do
    case field do
      field when field in ~w(td lng yds) ->
        sort_filtered_players_stats =
          [sorting: %{sort_by: String.to_atom(field), sort_order: :desc}]
          |> RushingToThescore.PlayerRepo.list()

        {:noreply, assign(socket, query: filter, stats: sort_filtered_players_stats)}

      _ ->
        {:noreply, socket}
    end
  end

  def handle_params(params, _uri, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end
end
