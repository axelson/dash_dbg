defmodule DashDbg.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DashDbgWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: DashDbg.PubSub},
      # Start Finch
      {Finch, name: DashDbg.Finch},
      # Start the Endpoint (http/https)
      DashDbgWeb.Endpoint
      # Start a worker by calling: DashDbg.Worker.start_link(arg)
      # {DashDbg.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DashDbg.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DashDbgWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
