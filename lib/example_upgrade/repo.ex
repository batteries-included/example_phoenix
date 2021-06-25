defmodule ExampleUpgrade.Repo do
  use Ecto.Repo,
    otp_app: :example_upgrade,
    adapter: Ecto.Adapters.Postgres
end
