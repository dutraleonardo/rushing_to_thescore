# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :rushing_to_thescore,
  ecto_repos: [RushingToThescore.Repo]

# Configures the endpoint
config :rushing_to_thescore, RushingToThescoreWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6FxoCpz3CSm1dbkqgXT0lAcF56oxbo5qmSvIl3twSGrDZPX8OQBB7OKTmbkbtKyD",
  render_errors: [view: RushingToThescoreWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RushingToThescore.PubSub,
  live_view: [signing_salt: "iI2Ja6pq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
