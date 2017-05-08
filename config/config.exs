# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :text_api,
  ecto_repos: [TextApi.Repo]

# Configures the endpoint
config :text_api, TextApi.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7RfnGD+uh9mZAPkYYLe9MCSC67m6m3M2tgLGkfwzDDKFxzKsh3E1AoYAbFVSFxtB",
  render_errors: [view: TextApi.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TextApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
