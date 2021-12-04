defmodule RushingToThescore.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      RushingToThescore.Repo,
      # Start the Telemetry supervisor
      RushingToThescoreWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: RushingToThescore.PubSub},
      # Start the Endpoint (http/https)
      RushingToThescoreWeb.Endpoint
      # Start a worker by calling: RushingToThescore.Worker.start_link(arg)
      # {RushingToThescore.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RushingToThescore.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RushingToThescoreWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
