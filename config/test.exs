import Config

config :ymn_tool, llm_templates_path: "test/data/llm_templates_data.txt"

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ymn_tool, YmnToolWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "kZZsXqr/simX4av0WK3WZfuN7wSgk7ilaLwYP70oD0kNlC0kTJ4JALiVqu9/UVV7",
  server: false

# In test we don't send emails
config :ymn_tool, YmnTool.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
