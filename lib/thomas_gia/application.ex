defmodule ThomasGIA.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ThomasGIAWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:thomas_gia, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ThomasGIA.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: ThomasGIA.Finch},
      # Start a worker by calling: ThomasGIA.Worker.start_link(arg)
      # {ThomasGIA.Worker, arg},
      # Start to serve requests, typically the last entry
      ThomasGIAWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ThomasGIA.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ThomasGIAWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
