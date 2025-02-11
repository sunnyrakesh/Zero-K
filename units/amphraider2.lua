unitDef = {
  unitname               = [[amphraider2]],
  name                   = [[Archer]],
  description            = [[Amphibious Raider/Riot Bot]],
  acceleration           = 0.2,
  activateWhenBuilt      = true,
  brakeRate              = 0.4,
  buildCostEnergy        = 200,
  buildCostMetal         = 200,
  buildPic               = [[amphraider2.png]],
  buildTime              = 200,
  canAttack              = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canStop                = true,
  category               = [[SINK]],
  corpse                 = [[DEAD]],

  customParams           = {
    amph_regen = 40,
    amph_submerged_at = 40,
	sink_on_emp    = 1,
    helptext       = [[The Archer uses a powerful water cutting jet to hit enemies. While the water cannon loses firepower and range as its water tank empties, it can be refilled by standing in a body of water. Archers can float to surface in order to fight naval units.]],
    description_pl = [[Plywajacy bot wsparcia]],
    helptext_pl    = [[Archer uzywa silnego strumienia wody do niszczenia przeciwnikow. W miare strzelania zbiornik oproznia sie, zmniejszajac sile i zasieg - Archer moze go ponownie napelnic, wchodzac do wody. Archer moze wynurzyc sie, aby prowadzic walke z jednostkami powierzchniowymi.]],
    maxwatertank   = [[180]],
    floattoggle    = [[1]],
  },

  explodeAs              = [[BIG_UNITEX]],
  footprintX             = 2,
  footprintZ             = 2,
  iconType               = [[amphraider]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  leaveTracks            = true,
  maxDamage              = 820,
  maxSlope               = 36,
  maxVelocity            = 2.5,
  minCloakDistance       = 75,
  movementClass          = [[AKBOT2]],
  noChaseCategory        = [[TERRAFORM FIXEDWING GUNSHIP HOVER SHIP SWIM SUB LAND FLOAT SINK TURRET]],
  objectName             = [[amphraider2.s3o]],
  script                 = [[amphraider2.lua]],
  seismicSignature       = 4,
  selfDestructAs         = [[BIG_UNITEX]],

  sfxtypes               = {
    explosiongenerators = {
      [[custom:watercannon_muzzle]],
    },
  },

  sightDistance          = 500,
  sonarDistance          = 200,
  trackOffset            = 0,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ComTrack]],
  trackWidth             = 22,
  turnRate               = 1200,
  upright                = true,

  weapons                = {
    {
      def                = [[WATERCANNON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },
	{
      def                = [[FAKE_WATERCANNON]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },

  weaponDefs             = {

    WATERCANNON = {
      name                    = [[Water Cutter]],
      areaOfEffect            = 128,
      beamTime                = 0.01,
      beamTtl                 = 10,
      beamDecay               = 0.80,
      coreThickness           = 0,
      craterBoost             = 0,
      craterMult              = 0,

      customParams            = {
        impulse = [[30]],
        impulsemaxdepth = [[20]],
        impulsedepthmult = [[0.5]],
        normaldamage = [[1]],

        statsdamage = 10.4,
		stats_hide_damage = 1, -- continuous laser
		stats_hide_reload = 1,
      },

      damage                  = {
        default = 1.3,
        subs    = 1,
      },

      explosionGenerator      = [[custom:watercannon_impact]],
      impactOnly              = false,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 0,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 0.1,
      rgbColor                = [[0.2 0.2 0.3]],
      scrollSpeed             = 10,
--      soundStart              = [[weapon/laser/laser_burn8]],
      soundTrigger            = true,
      sweepfire               = false,
      texture1	              = [[corelaser]],
      texture2                = [[wake]],
      texture3                = [[wake]],
      texture4                = [[wake]],
      thickness               = 7,
      tileLength              = 100,
      tolerance               = 5000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 500,
    },
	
    FAKE_WATERCANNON = {
      name                    = [[Fake Water Cutter]],
      areaOfEffect            = 128,
      beamTime                = 0.01,
      beamTtl                 = 10,
      beamDecay               = 0.80,
      coreThickness           = 0,
      craterBoost             = 0,
      craterMult              = 0,
	  
      customParams            = {
        impulse = [[30]],
        normaldamage = [[1]],
      },

      damage                  = {
        default = 1.3,
        subs    = 1,
      },

      explosionGenerator      = [[custom:watercannon_impact]],
      impactOnly              = false,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 0,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 300,
      reloadtime              = 0.1,
      rgbColor                = [[0.2 0.2 0.3]],
      scrollSpeed             = 10,
--      soundStart              = [[weapon/laser/laser_burn8]],
      soundTrigger            = true,
      sweepfire               = false,
      texture1	              = [[corelaser]],
      texture2                = [[wake]],
      texture3                = [[wake]],
      texture4                = [[wake]],
      thickness               = 7,
      tileLength              = 100,
      tolerance               = 5000,
      turret                  = true,
      waterWeapon             = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 500,
    },
  
  },

  featureDefs            = {

    DEAD      = {
      description      = [[Wreckage - Archer]],
      blocking         = true,
      damage           = 820,
      energy           = 0,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      metal            = 80,
      object           = [[amphraider2_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 104,
    },

    HEAP      = {
      description      = [[Debris - Archer]],
      blocking         = false,
      damage           = 820,
      energy           = 0,
      footprintX       = 2,
      footprintZ       = 2,
      metal            = 40,
      object           = [[debris2x2c.s3o]],
      reclaimable      = true,
      reclaimTime      = 52,
    },

  },

}

return lowerkeys({ amphraider2 = unitDef })
