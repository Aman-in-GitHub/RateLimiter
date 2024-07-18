defmodule RateLimiter.Application do
  @moduledoc """
  Documentation for `RateLimiter.Application`.
  """

  use Application

  @impl true
  def start(_type, _args) do
    children = []

    opts = [strategy: :one_for_one, name: RateLimiter.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
