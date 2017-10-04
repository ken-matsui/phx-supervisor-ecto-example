# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :supervisor_ecto,
  ecto_repos: [SupervisorEcto.Repo]

# Configures the endpoint
config :supervisor_ecto, SupervisorEctoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SlhHxJ8NYD2+I4Io0zozFyK6rqniP9F2sfLxaI0VrxEcpxbepUlcg5KJ3bYhJuc3",
  render_errors: [view: SupervisorEctoWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: SupervisorEcto.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
