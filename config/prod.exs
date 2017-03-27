use Mix.Config

config :felix,
  urls: System.get_env("URLS") |> String.split(",") |> Enum.map(&String.trim/1)
