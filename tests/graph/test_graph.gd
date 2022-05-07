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

func title() -> String:
	return "Graph Tests"

func start() -> void:
	pass

func pre() -> void:
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

func post() -> void:
	pass

func end() -> void:
	
	pass

func test_adjacency():
	
	asserts.is_true(G.adjacent(A, B))
	asserts.is_false(G.adjacent(A, C))
	asserts.is_true(G.adjacent(F, E))
	asserts.is_false(G.adjacent(F, B))
	asserts.is_false(G.adjacent(B, E))
	asserts.is_true(G.adjacent(B, C))

func test_neighbours():
	
	var neighbours_A = [B]
	var neighbours_B = [A, C, D]
	var neighbours_C = [B, E]
	var neighbours_D = [B, E]
	var neighbours_E = [C, D, F]
	var neighbours_F = [E]
	
	asserts.is_true(contains_same_elements(G.neighbours(A), neighbours_A))
	asserts.is_true(contains_same_elements(G.neighbours(B), neighbours_B))
	asserts.is_true(contains_same_elements(G.neighbours(C), neighbours_C))
	asserts.is_true(contains_same_elements(G.neighbours(D), neighbours_D))
	asserts.is_true(contains_same_elements(G.neighbours(E), neighbours_E))
	asserts.is_true(contains_same_elements(G.neighbours(F), neighbours_F))

func test_add_vertex():
	
	var Z = Vertex.new({"value":"Z"})
	var X = Vertex.new({"value":"X"})
	
	G.add_vertex(Z)
	G.add_vertex(X)
	
	asserts.is_true(Z in G.vertices)
	asserts.is_true(X in G.vertices)
	asserts.is_not_equal(Z.id, X.id)
	
	# testing against if you can add the same element again
	var size = G.vertices.size()
	G.add_vertex(Z)
	asserts.is_equal(G.vertices.size(), size)

func test_remove_vertex():
	
	# remove F
	G.remove_vertex(F)
	asserts.is_false(F in G.vertices)
	asserts.is_false(F in G.neighbours(E))
	
	# remove B
	G.remove_vertex(B)
	asserts.is_false(B in G.vertices)
	asserts.is_false(B in G.neighbours(A))
	asserts.is_false(B in G.neighbours(C))
	asserts.is_false(B in G.neighbours(D))
	
	# remove A
	G.remove_vertex(A)
	
	asserts.is_false(A in G.vertices)
	
	# remove C
	G.remove_vertex(C)
	
	asserts.is_false(C in G.vertices)
	asserts.is_false(C in G.neighbours(E))

func test_add_edge():
	
	# add edge A - C
	G.add_edge(A, C)
	
	asserts.is_true(A in G.neighbours(C))
	asserts.is_true(C in G.neighbours(A))
	
	
	# add edge B-E
	G.add_edge(B, E)
	
	asserts.is_true(B in G.neighbours(E))
	asserts.is_true(E in G.neighbours(B))

func test_remove_edge():
	
	# remove E-F
	G.remove_edge(E, F)
	
	asserts.is_false(E in G.neighbours(F))
	asserts.is_false(F in G.neighbours(E))
	
	# remove B-E doesn't exist
	var neighbours_B_count = G.neighbours(B).size()
	var neighbours_E_count = G.neighbours(E).size()
	G.remove_edge(B, E)
	
	asserts.is_true(neighbours_B_count == G.neighbours(B).size())
	asserts.is_true(neighbours_E_count == G.neighbours(E).size())
	
	# remove B-D
	G.remove_edge(B, D)
	
	asserts.is_false(B in G.neighbours(D))
	asserts.is_false(D in G.neighbours(B))
	
func test_reset_visited():
	
	
	A.visited = true
	E.visited = true
	
	var count_visited = 0
	for vertex in G.vertices:
		if vertex.visited:
			count_visited += 1
	
	asserts.is_true(count_visited == 2)
	
	G.reset_visited()
	count_visited = 0
	for vertex in G.vertices:
		if vertex.visited:
			count_visited+=1
	
	asserts.is_true(count_visited == 0)

# ************************************************************ #

func contains_same_elements(set_of_vertices_A, set_of_vertices_B):
	
	if set_of_vertices_A.size() != set_of_vertices_B.size():
		return false
	
	for v in set_of_vertices_A:
		if not v in set_of_vertices_B:
			return false
	
	return true
