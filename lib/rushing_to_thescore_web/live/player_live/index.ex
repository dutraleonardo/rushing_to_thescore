defmodule RushingToThescoreWeb.PlayerLive.Index do
  use RushingToThescoreWeb, :live_view

  alias RushingToThescore.PlayerRepo
  require IEx

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(
       socket,
       stats: [],
       search_query: ""
     )
     |> assign(:uploaded_files, [])
     |> allow_upload(:data, accept: ~w(.json), max_entries: 1)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    formatted_params = format_params(params)

    players =
      PlayerRepo.list(
        filter: formatted_params.filter,
        sorting: formatted_params.sort_params,
        pagination: formatted_params.pagination_options
      )

    search_query =
      Map.merge(formatted_params.pagination_options, formatted_params.sort_params)
      |> Map.put(:player, formatted_params.player)

    socket =
      assign(socket,
        players: players,
        search_query: search_query
      )

    {:noreply, assign(socket, stats: players)}
  end

  defp format_params(params) do
    player = params["player_name"] || ""
    sort_by = (params["sort_by"] || "id") |> String.to_atom()
    sort_order = (params["sort_order"] || "asc") |> String.to_atom()
    page = String.to_integer(params["page"] || "1")
    per_page = String.to_integer(params["per_page"] || "5")

    pagination_options = %{page: page, per_page: per_page}
    sort_params = %{sort_by: sort_by, sort_order: sort_order}

    filter = %{player: String.capitalize(player)}

    %{
      filter: filter,
      player: player,
      sort_params: sort_params,
      pagination_options: pagination_options
    }
  end

  defp sort_column(socket, text, sort_by, search_query) do
    live_patch(text,
      to:
        Routes.player_index_path(
          socket,
          :index,
          player: search_query.player,
          sort_by: sort_by,
          sort_order: toggle_sort(search_query.sort_order),
          page: search_query.page,
          per_page: search_query.per_page
        )
    )
  end

  defp toggle_sort(:desc), do: :asc
  defp toggle_sort(:asc), do: :desc

  defp data_pagination(socket, text, page, search_query, class) do
    live_patch(text,
      to:
        Routes.player_index_path(
          socket,
          :index,
          page: page,
          per_page: search_query.per_page,
          sort_by: search_query.sort_by,
          sort_order: search_query.sort_order,
          player: search_query.player
        ),
      class: class
    )
  end
end
