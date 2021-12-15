defmodule RushingToThescoreWeb.DownloadController do
  use RushingToThescoreWeb, :controller

  def index(
        conn,
        %{"player" => player, "sort_order" => sort_order, "sort_by" => sort_by, "page" => page, "per_page" => per_page} =
          _params
      ) do
    [
      filter: %{player: player},
      sorting: %{sort_by: String.to_atom(sort_by), sort_order: String.to_atom(sort_order)},
      pagination: %{page: String.to_integer(page), per_page: String.to_integer(per_page)}
    ]
    |> download(conn)
  end

  def index(
        conn,
        %{"player" => player, "sort_order" => sort_order, "sort_by" => sort_by} = _params
      ) do
    [
      filter: %{player: player},
      sorting: %{sort_by: String.to_atom(sort_by), sort_order: String.to_atom(sort_order)}
    ]
    |> download(conn)
  end

  defp download(filter, conn) do
    data = RushingToThescore.PlayerRepo.list(filter)

    csv_file = RushingToThescore.Helpers.FileExporter.call(data)

    conn
    |> put_resp_content_type("text/csv")
    |> put_resp_header("content-disposition", "attachment; filename=rushing_to_thescore.csv")
    |> send_resp(200, csv_file)
  end
end
