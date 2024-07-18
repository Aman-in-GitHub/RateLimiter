defmodule RateLimiter.Limiter do
  @moduledoc """
  Documentation for `RateLimiter.Limiter`.
  """

  import Plug.Conn
  require Logger

  @max_requests 10
  @time_limit 60

  def init(options), do: options

  def call(conn, _opts) do
    case check_limit(conn.remote_ip) do
      :ok ->
        conn

      {:error, reason} ->
        conn
        |> put_status(429)
        |> put_resp_content_type("application/json")
        |> send_resp(429, Jason.encode!(%{status: 429, message: reason}))
        |> halt()
    end
  end

  defp check_limit(ip) do
    current_time = System.system_time(:second)
    key = {ip, :rate_limiter}

    case :ets.lookup(:limiter_table, key) do
      [{^key, count, created_at}]
      when current_time - created_at <= @time_limit ->
        if count < @max_requests do
          Logger.info("Updating limit for #{inspect(key)} | Count:#{count + 1}")

          :ets.update_counter(:limiter_table, key, 1)
          :ok
        else
          Logger.info(
            "Rate limit exceeded for #{inspect(key)} | Timestamp = #{NaiveDateTime.to_string(NaiveDateTime.utc_now())}"
          )

          {:error, "Rate limit exceeded"}
        end

      [{^key, _count, created_at}] when current_time - created_at > @time_limit ->
        Logger.info("Resetting rate limiting for #{inspect(key)} | Count 1")

        :ets.insert(:limiter_table, {key, 1, current_time})
        :ok

      [] ->
        Logger.info("Initializing rate limiting for #{inspect(key)} | Count 1")
        :ets.insert(:limiter_table, {key, 1, current_time})
        :ok
    end
  end
end
