local name = "commweapon_hparticlebeam"
local weaponDef = {
	name                    = [[Heavy Particle Beam]],
	beamDecay               = 0.9,
	beamTime                = 0.01,
	beamttl                 = 75,
	coreThickness           = 0.5,
	craterBoost             = 0,
	craterMult              = 0,

	customParams            = {
		slot = [[5]],
	},

	damage                  = {
		default = 500,
		subs    = 18,
	},

	explosionGenerator      = [[custom:greencannonimpact]],
	fireStarter             = 100,
	impactOnly              = true,
	impulseFactor           = 0,
	interceptedByShieldType = 1,
	laserFlareSize          = 10,
	minIntensity            = 1,
	pitchtolerance          = 8192,
	range                   = 350,
	reloadtime              = 4,
	rgbColor                = [[0 1 0]],
	soundStart              = [[weapon/laser/small_laser_fire4]],
	soundStartVolume        = 5,
	thickness               = 8,
	tolerance               = 8192,
	turret                  = true,
	weaponType              = [[BeamLaser]],
}

return name, weaponDef
