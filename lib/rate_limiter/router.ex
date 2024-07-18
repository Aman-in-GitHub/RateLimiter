defmodule RateLimiter.Router do
  @moduledoc """
  Documentation for `RateLimiter.Router`.
  """

  use Plug.Router

  plug(:match)
  plug(RateLimiter.Limiter)
  plug(:dispatch)

  get "/" do
    send_resp(conn, 200, "Hello World")
  end

  get "/json" do
    case Jason.encode(%{status: 200, message: "Hello World"}) do
      {:ok, json} ->
        conn |> put_resp_content_type("application/json") |> send_resp(200, json)

      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(500, Jason.encode!(%{status: 500, message: "Internal server error"}))
    end
  end

  match _ do
    send_resp(conn, 404, "404 Not Found")
  end
end
