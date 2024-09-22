defmodule YmnTool.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      YmnToolWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:ymn_tool, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: YmnTool.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: YmnTool.Finch},
      # Start a worker by calling: YmnTool.Worker.start_link(arg)
      # {YmnTool.Worker, arg},
      # Start to serve requests, typically the last entry
      YmnToolWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: YmnTool.Supervisor]
    load_parlance_list()
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    YmnToolWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp load_parlance_list() do
    parlance_list =
      File.read!("q_list.txt")
      |> String.split("\n")

    FastGlobal.put(:parlance_list, parlance_list)
  end
end
