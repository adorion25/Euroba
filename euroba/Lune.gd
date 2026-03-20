extends RigidBody3D
class_name Lune
@export_group("Simulation gravitationnelle")
@export var masse_centre_rotation : float
@export var masse_corps : float
@export var periode_relative : float

@export_group("Point 1 d'Europe")
@export var rayon_initial_1 : float
@export var vitesse_initiale_1 : float

@export_group("Point 2 d'Europe")
@export var rayon_initial_2 : float
@export var vitesse_initiale_2 : float

@export_group("Paramètres ressort")
@export var elasticite : float
@export var distance_equilibre : float
@export var coeff_dissipation : float

@export_group("Paramètres d'Euler")
@export var etapes_calcul_par_ecran : int

var G : float = 6.673e-11
var r_1 : Vector3
var v_1 : Vector3
var r_2 : Vector3
var v_2 : Vector3
var periode : float
var distance : float = distance_equilibre
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	r_1 = rayon_initial_1 * Vector3(1, 0, 0)
	v_1 = vitesse_initiale_1 * Vector3(0, 0, 1)
	r_2 = rayon_initial_2 * Vector3(1, 0, 0)
	v_2 = vitesse_initiale_2 * Vector3(0, 0, 1)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func force_gravitationnelle(r_i: Vector3) -> Vector3:
	"""
	Applique la formule de la force gravitationnelle sur un des points d'Europe
	
	Paramètres:
	r_i -- Vecteur position du point selon Jupiter
	
	Retour:
	Vecteur correspondant à la force gravitationnelle exercée par Jupiter sur le point
	"""
	var force_g = -1 * G * (masse_corps/2 * masse_centre_rotation) / r_i.length()**3 * r_i
	return force_g

func force_ressort(r_1: Vector3, r_2: Vector3) -> Vector3:
	"""
	Applique la formule de la force du ressort sur un point de la lune selon la distance entre les deux points
	
	Paramètres:
	r_1 -- Vecteur position du point selon Jupiter
	r_2 -- Vecteur position du point selon Jupiter
	
	Retour:
	Vecteur correspondant à la force de ressort exercée par un point sur l'autre
	"""
	var k = elasticite
	var r_21 = r_2 - r_1
	var F_res = k * (r_21.length() - distance) * (r_21 / r_21.length())
	return F_res
	
func appliquer_euler(temps_dernier_ecran : float) -> void:
	"""
	Applique la méthode d'Euler pour déterminer la position et la vitesse selon
	le temps de la simulation.
	
	Paramètre:
	temps_dernier_ecran -- le temps écoulé depuis le dernier écran.
	"""
	pass
