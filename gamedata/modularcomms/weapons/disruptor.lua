local name = "commweapon_disruptor"
local weaponDef = {
	name                    = [[Disruptor Pulse Beam]],
	areaOfEffect            = 32,
	beamdecay               = 0.9,
	beamTime                = 0.03,
	beamttl                 = 50,
	coreThickness           = 0.25,
	craterBoost             = 0,
	craterMult              = 0,

	customParams            = {
		--timeslow_preset       = [[module_disruptorbeam]],
		timeslow_damagefactor = [[2]],
	},

	damage                  = {
		default = 225,
	},

	explosionGenerator      = [[custom:flash2purple]],
	fireStarter             = 30,
	impactOnly              = true,
	impulseBoost            = 0,
	impulseFactor           = 0.4,
	interceptedByShieldType = 1,
	largeBeamLaser          = true,
	laserFlareSize          = 4.33,
	minIntensity            = 1,
	noSelfDamage            = true,
	range                   = 350,
	reloadtime              = 2,
	rgbColor                = [[0.3 0 0.4]],
	soundStart              = [[weapon/laser/heavy_laser5]],
	soundStartVolume        = 3,
	soundTrigger            = true,
	texture1                = [[largelaser]],
	texture2                = [[flare]],
	texture3                = [[flare]],
	texture4                = [[smallflare]],
	thickness               = 12,
	tolerance               = 18000,
	turret                  = true,
	weaponType              = [[BeamLaser]],
	weaponVelocity          = 500,
}

return name, weaponDef
