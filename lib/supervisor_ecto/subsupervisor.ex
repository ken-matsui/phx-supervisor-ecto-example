defmodule SupervisorEcto.SubSupervisor do
	use Supervisor

	def start_link(stash_pid) do
		{:ok, _pid} = Supervisor.start_link(__MODULE__, stash_pid)
	end
	def init(_stash_pid) do
		# ectoから，id: 1のデータを取得
		data = SupervisorEcto.Json.get_count!(1)

		child_processes = [ worker(SupervisorEcto.Counter, [data.count]) ]
		supervise child_processes, strategy: :one_for_one
	end
end