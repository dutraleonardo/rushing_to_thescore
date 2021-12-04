defmodule RushingToThescore.Repo do
  use Ecto.Repo,
    otp_app: :rushing_to_thescore,
    adapter: Ecto.Adapters.Postgres
end
