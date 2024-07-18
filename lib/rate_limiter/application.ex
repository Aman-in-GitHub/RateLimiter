defmodule RateLimiter.Application do
  @moduledoc """
  Documentation for `RateLimiter.Application`.
  """

  require Logger

  use Application

  @impl true
  def start(_type, _args) do
    RateLimiter.init()

    port = String.to_integer(System.get_env("PORT") || "9696")

    children = [
      {Plug.Cowboy, scheme: :http, plug: RateLimiter.Router, options: [port: port]}
    ]

    Logger.info("Listening at http://localhost:#{port}")

    table = :ets.new(:limiter_table, [:set, :public, :named_table])

    Logger.info("Created :ets table: #{table}")

    opts = [strategy: :one_for_one, name: RateLimiter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
