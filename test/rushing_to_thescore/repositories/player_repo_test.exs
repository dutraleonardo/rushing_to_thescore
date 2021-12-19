defmodule RushingToThescore.PlayerRepoTest do
  use RushingToThescore.DataCase

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

  describe "create/1" do
    test "success when try to create a player with all required fields" do
      {status, player} =
        List.first(@create_players)
        |> PlayerRepo.create()

      assert status == :ok
      refute(is_nil(player))
    end

    test "do not create a player without a required field" do
      {status, player} =
        List.first(@create_players)
        |> Map.delete(:team)
        |> PlayerRepo.create()

      assert status == :error
      assert player.valid? == false

      {_, {_, error_cause}} = List.first(player.errors)
      assert error_cause == [validation: :required]
    end
  end

  describe "list/1" do
    setup [:insert_players]

    test "list all players" do
      players = PlayerRepo.list()
      refute(is_nil(players))
      assert length(players) == 2
    end

    test "filter player by full name and part of his name" do
      query_full_name = PlayerRepo.list(filter: %{player: "Joe Banyard"})
      query_part_name = PlayerRepo.list(filter: %{player: "Banyard"})
      refute(is_nil(query_full_name))
      refute(is_nil(query_part_name))
      assert List.first(query_full_name).player == "Joe Banyard"
      assert List.first(query_part_name).player == "Joe Banyard"
    end

    test "filter by a nonexistent player" do
      query_ghost = PlayerRepo.list(filter: %{player: "Ghost"})
      assert query_ghost == []
    end

    test "test pagination" do
      paginated = PlayerRepo.list(pagination: %{page: 1, per_page: 1})
      assert length(paginated) == 1
    end

    test "test sort" do
      sort_by_att_desc = PlayerRepo.list(sorting: %{sort_by: :att, sort_order: :desc})
      sort_by_att_asc = PlayerRepo.list(sorting: %{sort_by: :att, sort_order: :asc})
      assert List.first(sort_by_att_desc).player == "Shaun Hill"
      assert List.first(sort_by_att_asc).player == "Joe Banyard"
    end
  end

  defp insert_players(_) do
    Enum.map(
      @create_players,
      fn player -> PlayerRepo.create(player) end
    )
  end
end
