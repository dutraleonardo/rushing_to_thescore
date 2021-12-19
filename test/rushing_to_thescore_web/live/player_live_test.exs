defmodule RushingToThescoreWeb.PlayerLiveTest do
  use RushingToThescoreWeb.ConnCase

  import Phoenix.LiveViewTest

  alias RushingToThescore.PlayerRepo

  @create_players [
    %{
      att: 2.0,
      att_g: 2.0,
      avg: 3.5,
      first_down: 0.0,
      first_down_porcent: 0.0,
      forty_plus: 0.0,
      fum: 0.0,
      lng: "7",
      player: "Joe Banyard",
      pos: "RB",
      td: 0.0,
      team: "JAX",
      twenty_plus: 0.0,
      yds: 7.0,
      yds_g: 7.0
    },
    %{
      att: 5.0,
      att_g: 1.7,
      avg: 1.0,
      first_down: 0.0,
      first_down_porcent: 0.0,
      forty_plus: 0.0,
      fum: 0.0,
      lng: "9",
      player: "Shaun Hill",
      pos: "QB",
      td: 0.0,
      team: "MIN",
      twenty_plus: 0.0,
      yds: 5.0,
      yds_g: 1.7
    }
  ]

  describe "Index" do
    setup [:insert_players]

    test "lists all players", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, Routes.player_index_path(conn, :index))

      assert html =~ "Shaun Hill"
      assert html =~ "Joe Banyard"
    end
  end

  defp insert_players(_) do
    Enum.map(
      @create_players,
      fn player -> PlayerRepo.create(player) end
    )
  end
end
