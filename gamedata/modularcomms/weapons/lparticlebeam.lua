local name = "commweapon_lparticlebeam"
local weaponDef = {
	name                    = [[Light Particle Beam]],
	beamDecay               = 0.85,
	beamTime                = 0.01,
	beamttl                 = 45,
	coreThickness           = 0.5,
	craterBoost             = 0,
	craterMult              = 0,

	customParams            = {
		slot = [[5]],
	},

	damage                  = {
		default = 39,
		subs    = 2.05,
	},

	explosionGenerator      = [[custom:flash1red]],
	fireStarter             = 100,
	impactOnly              = true,
	impulseFactor           = 0,
	interceptedByShieldType = 1,
	laserFlareSize          = 4.5,
	minIntensity            = 1,
	pitchtolerance          = 8192,
	range                   = 330,
	reloadtime              = 10/30,
	rgbColor                = [[1 0 0]],
	soundStart              = [[weapon/laser/mini_laser]],
	soundStartVolume        = 5,
	thickness               = 4,
	tolerance               = 8192,
	turret                  = true,
	weaponType              = [[BeamLaser]],
}

return name, weaponDef
