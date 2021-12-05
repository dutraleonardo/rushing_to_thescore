# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     RushingToThescore.Repo.insert!(%RushingToThescore.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

{:ok, players_statistics} = RushingToThescore.Helpers.FileImporter.json_importer("rushing.json")

Enum.each(players_statistics, fn player_stats ->
  RushingToThescore.Player.changeset(
    %RushingToThescore.Player{},
    %{
      player: player_stats["Player"],
      team: player_stats["Team"],
      pos: player_stats["Pos"],
      att_g: player_stats["Att/G"],
      att: player_stats["Att"],
      yds: player_stats["Yds"],
      avg: player_stats["Avg"],
      yds_g: player_stats["Yds/G"],
      td: player_stats["TD"],
      lng: player_stats["Lng"],
      first_down: player_stats["1st"],
      first_down_porcent: player_stats["1st%"],
      twenty_plus: player_stats["20+"],
      forty_plus: player_stats["40+"],
      fum: player_stats["FUM"]
    }
  )
  |> RushingToThescore.Repo.insert!()
end)
