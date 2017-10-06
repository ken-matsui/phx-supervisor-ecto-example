defmodule SupervisorEcto.Counter do
	use GenServer

	# # # # #
	# 外部API
	def start_link(initial_num) do
		GenServer.start_link(__MODULE__, %{last_message: "start_link", count: init_num}, name: __MODULE__)
	end

	def get_state do
		GenServer.call(__MODULE__, :get)
	end

	def increment do
		GenServer.cast(__MODULE__, :inc)
	end

	def kill do
		# handle_castとのmissmatchでエラーを起こす．
		GenServer.cast(__MODULE__, :kill)
	end

	# # # # #
	# 内部API
	def handle_call(:get, _from, state) do
		{:reply, state, state}
	end

	def handle_call(:inc, state) do
		new_state = %{count: state.count + 1, last_message: "inc"}
		# ectoに値を保管
		now_state = SupervisorEcto.Json.get_count!(1)
		SupervisorEcto.Json.update_count(now_state, %{count: new_state.count})
		{:noreply, new_state}
	end
end