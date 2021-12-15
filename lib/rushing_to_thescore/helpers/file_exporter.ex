defmodule RushingToThescore.Helpers.FileExporter do
  @headers [
    "Player",
    "Team",
    "Pos",
    "Att",
    "Att/G",
    "Yds",
    "Avg",
    "Yds/G",
    "TD",
    "Lng",
    "1st",
    "1st%",
    "20+",
    "40+",
    "FUM"
  ]

  def call(data) do
    data_parser(data)
    |> CSV.encode(headers: @headers)
    |> Enum.to_list()
  end

  def data_parser(data) do
    Stream.map(data, fn row ->
      %{
        "Player" => row.player,
        "Team" => row.team,
        "Pos" => row.pos,
        "Att" => row.att,
        "Att/G" => row.att_g,
        "Yds" => row.yds,
        "Avg" => row.avg,
        "Yds/G" => row.yds_g,
        "TD" => row.td,
        "Lng" => row.lng,
        "1st" => row.first_down,
        "1st%" => row.first_down_porcent,
        "20+" => row.twenty_plus,
        "40+" => row.forty_plus,
        "FUM" => row.fum
      }
    end)
  end
end
