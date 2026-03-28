class_name Lasso
extends Line2D

const LASSO_SPEED_INC = 10
const LASSO_SPEED_REMTIMES = 3

var increasing := true
var spawnX := 0.0
var spawnY := 0.0
var finalX := 0.0
var finalY := 0.0
var startX := 0.0
var startY := 0.0

func follow(x: float, y: float) -> void:
	if x == startX and y == startY:
		return
	
	var sx = startX
	var sy = startY
	startX = x
	startY = y
	
	if points.size() < 2:
		points.insert(0, Vector2(sx, sy))
		return
	
	var f = points[1]
	var v = Vector2(f.x - x, f.y - y)
	if v.length() < LASSO_SPEED_INC:
		points[0] = Vector2(x, y)
	else:
		points.insert(0, Vector2(x, y))

func set_spawn(x: float, y: float) -> void:
	spawnX = x
	spawnY = y
	startX = x
	startY = y
	points.append(Vector2(x, y))

func get_lasso_point() -> Vector2:
	if points.size() < 1:
		return Vector2(self.spawnX, self.spawnY)
	
	var sx = points[points.size() - 1].x
	var sy = points[points.size() - 1].y
	var dx = finalX - sx
	var dy = finalY - sy
	var dist = sqrt(dx * dx + dy * dy)
	
	if dist <= LASSO_SPEED_INC:
		return Vector2(finalX, finalY)
	else:
		var ratio = LASSO_SPEED_INC / dist
		return Vector2(sx + dx * ratio, sy + dy * ratio)

func append_point(x: float, y: float) -> void:
	finalX = x
	finalY = y
	
	var last = points[points.size() - 1]
	var v = Vector2(x - last.x, y - last.y)
	if v.length() < LASSO_SPEED_INC:
		return
	
	var delta = v.normalized() * LASSO_SPEED_INC
	points.append(last + delta)

func rmPoint() -> void:
	for i in range(LASSO_SPEED_REMTIMES):
		if points.size() == 0:
			break
		points.remove_at(points.size() - 1)

func has_lasso() -> bool:
	return points.size() > 0

func _process(delta: float) -> void:
	if points.size() < 2:
		return
	
	var line_points: Array = []
	for i in range(points.size()):
		var start = points[i]
		var end: Vector2
		
		if i < points.size() - 1:
			end = points[i + 1]
		elif increasing:
			end = get_lasso_point()
			if end == null:
				end = start
		else:
			break
		
		line_points.append(start)
		line_points.append(end)
	
	self.points = line_points
	self.width = 3
	self.default_color = Color(0.5, 0, 0.5) # violet
