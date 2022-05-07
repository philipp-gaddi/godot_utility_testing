extends WATTest

# graph
var G:Graph

# vertices
var A:Vertex
var B:Vertex
var C:Vertex
var D:Vertex
var E:Vertex
var F:Vertex


func title():
	
	return "Graph Iterator Tests"

func start():
	pass

func pre():
	# the test graph looks like
	# A:[B]
	# B:[A, C, D]
	# C:[B, E]
	# D:[B, E]
	# E:[C, D, F]
	# F:[E]
	
	G = Graph.new()
	
	A = Vertex.new({"value":"A"})
	B = Vertex.new({"value":"B"})
	C = Vertex.new({"value":"C"})
	D = Vertex.new({"value":"D"})
	E = Vertex.new({"value":"E"})
	F = Vertex.new({"value":"F"})
	
	G.add_vertex(A)
	G.add_vertex(B)
	G.add_vertex(C)
	G.add_vertex(D)
	G.add_vertex(E)
	G.add_vertex(F)
	
	G.add_edge(A, B)
	G.add_edge(B, C)
	G.add_edge(B, D)
	G.add_edge(C, E)
	G.add_edge(D, E)
	G.add_edge(E, F)

func post():
	pass

func end():
	pass



func test_depth_first_search():
	 
	# find A from A
	var dfs = DFS_itr.new(G, A, "value", "A")
	dfs.next()
	asserts.is_true(A == dfs.result)
	
	# find A from F
	G.reset_visited()
	dfs = DFS_itr.new(G, F, "value", "A")
	dfs.next()
	asserts.is_true(A == dfs.result)
	
	# Try to find A with no edge leading to A
	G.remove_edge(A, B)
	G.reset_visited()
	dfs = DFS_itr.new(G, F, "value", "A")
	asserts.is_true(null == dfs.next())

func test_dfs_continue_search():
	
	var A2 = Vertex.new({"value":"A"})
	var dfs = DFS_itr.new(G, F, "value", "A")
	G.add_vertex(A2)
	G.add_edge(A, A2)
	
	dfs.next()
	asserts.is_true("A" == dfs.result.data["value"])
	
	dfs.next()
	asserts.is_true("A" == dfs.result.data["value"])

func test_breadth_first_search():
	
	# find A from A
	var bfs = BFS_itr.new(G, A, "value", "A")
	bfs.next()
	asserts.is_true(A == bfs.result)
	
	# find A from f
	G.reset_visited()
	bfs = BFS_itr.new(G, F, "value", "A")
	bfs.next()
	asserts.is_true(A == bfs.result)
	
	# find A with no leading edge to it
	G.reset_visited()
	G.remove_edge(A, B)
	bfs = BFS_itr.new(G, F, "value", "A")
	bfs.next()
	asserts.is_true(null == bfs.result)
	
func test_bfs_continue_search():
	
	var A2 = Vertex.new({"value":"A"})
	var bfs = BFS_itr.new(G, F, "value", "A")
	G.add_vertex(A2)
	G.add_edge(A, A2)
	
	bfs.next()
	asserts.is_true("A" == bfs.result.data["value"])
	
	bfs.next()
	asserts.is_true("A" == bfs.result.data["value"])


