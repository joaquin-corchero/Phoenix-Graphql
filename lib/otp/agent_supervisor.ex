defmodule PhoenixGraphql.AgentSupervisor do
  use Supervisor

  def start_link do
    IO.inspect("---------------------")
    IO.inspect("Supervisor started!!!!")
    IO.inspect("---------------------")
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(_opts) do
    children = [
      worker(PhoenixGraphql.PostAgent, [], restart: :temporary)
      #worker(PhoenixGraphql.PostAgent, [PhoenixGraphql.PostAgent])
    ]

    supervise(children, strategy: :one_for_one)
  end
end
