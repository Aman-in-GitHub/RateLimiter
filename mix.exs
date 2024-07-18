defmodule RateLimiter.MixProject do
  use Mix.Project

  def project do
    [
      app: :rate_limiter,
      version: "0.1.0",
      elixir: "~> 1.18-dev",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      mod: {RateLimiter.Application, []},
      extra_applications: [:logger]
    ]
  end

  defp deps do
    []
  end
end
