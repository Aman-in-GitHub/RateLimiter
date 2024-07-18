defmodule RateLimiterTest do
  use ExUnit.Case
  doctest RateLimiter

  test "ok" do
    assert RateLimiter.init() == :ok
  end
end
