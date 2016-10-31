defmodule PhoenixGraphql do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      supervisor(PhoenixGraphql.Endpoint, []),
      # adding the agent to the supervision tree
      worker(PhoenixGraphql.PostAgent, []),
      worker(PhoenixGraphql.UserAgent, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixGraphql.Supervisor]
    Supervisor.start_link(children, opts)

    #PhoenixGraphql.AgentSupervisor.start_link
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixGraphql.Endpoint.config_change(changed, removed)
    :ok
  end
end
