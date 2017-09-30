# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :parallel_serial,
  ecto_repos: [ParallelSerial.Repo]

# Configures the endpoint
config :parallel_serial, ParallelSerialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "d9CChR2tlYkV0pWJUu6i3sl0nfq9JUCq7I+nRFcy//xfgnFbpMF8SqIyn5+TiXN4",
  render_errors: [view: ParallelSerialWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ParallelSerial.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
