# RateLimiter

A rate limiter built in Elixir using the [:ets](https://www.erlang.org/doc/apps/stdlib/ets.html) module

## Installation

- Make sure you have Erlang and Elixir installed in your system.
- Clone this Git repository: `git clone https://github.com/Aman-in-GitHub/RateLimiter`
- Change into the project directory: `cd RateLimiter`
- Run `mix deps.get` to install dependencies
- Run `mix` to start your RateLimiter

## Features

- **Rate Limiting:** Implements a customizable rate limiting mechanism to control request frequency.

- **Plug-based Routing:** Utilizes Plug.Router for efficient HTTP request routing and handling.

- **IP-based Tracking:** Tracks and limits requests based on the client's IP address.

- **Configurable Limits:** Allows easy configuration of maximum requests and time window for rate limiting.

- **ETS-based Storage:** Utilizes Erlang Term Storage (ETS) for efficient, in-memory storage of rate limiting data.

- **Auto-resetting Limits:** Automatically resets rate limits after the specified time window.

- **Stateless Design:** Maintains a stateless architecture, with all necessary state stored in ETS.
