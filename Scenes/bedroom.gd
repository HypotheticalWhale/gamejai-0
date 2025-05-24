extends Control

func _ready() -> void:
	await update_picture_id2coord()
	await initialize_picture()
	
func get_adjacent_gap(tile_coord):
	# id 8 represents gap
	if Globals.picture_coord2id[tile_coord] == Globals.gap_id:
		return Vector2(-1,-1)
	print("getting gap")
	for direction in [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN]:
		var adjacent_coord = tile_coord + direction
		if adjacent_coord not in Globals.picture_coord2id.keys():
			continue
		if Globals.picture_coord2id[adjacent_coord] == Globals.gap_id:
			return adjacent_coord
	
	# if no missing gaps found, return (-1,-1)
	return Vector2(-1,-1)


func fill_gap(initial_coord, final_coord):
	# final coord must always be a gap)
	assert(Globals.picture_coord2id[final_coord] == Globals.gap_id)
	
	# animate the sliding of the tile
	var tile_nodes_ordered_by_id: Array = %ScrambledPictureTiles.get_children()
	var tween = get_tree().create_tween()
	var initial_tile_node = tile_nodes_ordered_by_id[Globals.picture_coord2id[initial_coord]]
	tween.tween_property(initial_tile_node, "global_position", (final_coord * Globals.tile_length) + Globals.picture_global_position, 0.2)

	# "move" the gap (you won't see this)
	var gap_tile_node = tile_nodes_ordered_by_id[Globals.picture_coord2id[final_coord]]
	gap_tile_node.global_position = (initial_coord * Globals.tile_length) + Globals.picture_global_position
	
	# update the dictionaries
	var temp_id = Globals.picture_coord2id[initial_coord]
	Globals.picture_coord2id[initial_coord] = Globals.picture_coord2id[final_coord]
	Globals.picture_coord2id[final_coord] = temp_id
	await update_picture_id2coord()
	

func is_picture_unscrambled():
	var current_picture = Globals.picture_coord2id.values()
	var ordered_picture = current_picture.duplicate(true)
	ordered_picture.sort()
	print(current_picture)
	print(ordered_picture)
	if current_picture == ordered_picture:
		%IsSolved.text = "solved"
		return true
	
	%IsSolved.text = "not solved"
	return false


func initialize_picture():
	var i = 0
	#var j = 0
	for tile in %ScrambledPictureTiles.get_children():
		#tile.global_position = Vector2(i*tile_length, j*tile_length) + picture_global_position
		tile.global_position = Globals.picture_id2coord[i]*Globals.tile_length + Globals.picture_global_position
		tile.get_node("CollisionShape2D").shape.size = Vector2(Globals.tile_length * 2/3, Globals.tile_length * 2/3)
		tile.input_event.connect(_on_tile_clicked)
		i += 1
		#if i > num_rows-1:
			#i = 0
			#j += 1


func _on_tile_clicked(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed:
		print(event.position)
		var tile_coord_clicked = ((event.position - Globals.picture_global_position) / Globals.tile_length).round()
		print(tile_coord_clicked)
		var adjacent_gap = get_adjacent_gap(tile_coord_clicked)
		if adjacent_gap != (Vector2(-1,-1)):
			print("sliding")
			await fill_gap(tile_coord_clicked, adjacent_gap)
		else:
			print("not sliding")
		print(is_picture_unscrambled())
			

func update_picture_id2coord():
	for coord in Globals.picture_coord2id:
		Globals.picture_id2coord[Globals.picture_coord2id[coord]] = coord

func _on_exit_picture_pressed() -> void:
	%ScrambledPicture.visible = false
