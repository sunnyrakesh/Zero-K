unitDef = {
  unitname                      = [[corllt]],
  name                          = [[Lotus]],
  description                   = [[Light Laser Tower]],
  acceleration                  = 0,
  brakeRate                     = 0,
  buildAngle                    = 32768,
  buildCostEnergy               = 90,
  buildCostMetal                = 90,
  builder                       = false,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 4,
  buildingGroundDecalSizeY      = 4,
  buildingGroundDecalType       = [[corllt_aoplane.dds]],
  buildPic                      = [[CORLLT.png]],
  buildTime                     = 90,
  canAttack                     = true,
  canstop                       = [[1]],
  category                      = [[FLOAT TURRET]],
  collisionVolumeOffsets        = [[0 0 0]],
  collisionVolumeScales         = [[30 90 30]],
  collisionVolumeTest           = 1,
  collisionVolumeType           = [[CylY]],
  corpse                        = [[DEAD]],

  customParams                  = {
    description_fr = [[Tourelle Laser Légcre]],
	description_de = [[Leichter Laserturm]],
	description_pl = [[Lekka wiezyczka laserowa]],
    helptext       = [[The Lotus is a basic turret. A versatile, solid anti-ground weapon, it does well versus scouts as well as being able to take on one or two raiders. Falls relatively easily to skirmishers, artillery or assault units unless supported.]],
    helptext_fr    = [[La Tourelle Laser Légcre aussi appellée LLT est une tourelle basique, peu solide mais utile pour se protéger des éclaireurs ou des pilleurs. Des tirailleurs ou de l'artillerie en viendrons rapidement r bout. ]],
	helptext_de    = [[Der Lotus ist einer der Basisgeschütztürme. Eine wendige, massive Anti-Boden Waffe ermöglicht ihm die Verteidigung gegen Aufklärer oder auch ein, oder zwei Raidern. Von Skirmishern, Artillerie oder Sturmeinheiten kann er allerdings ohne Schutz sehr schnell überwältigt werden.]],
	helptext_pl    = [[Lotos to podstawowa wiezyczka. Posiada celny laser, ktory dobrze radzi sobie z lekkimi jednostkami, ale samotna wiezyczka nie jest w stanie poradzic sobie z wiekszymi oddzialami, artyleria lub jednostkami szturmowymi.]],
    aimposoffset   = [[0 32 0]],
  },

  explodeAs                     = [[SMALL_BUILDINGEX]],
  footprintX                    = 2,
  footprintZ                    = 2,
  healtime                      = [[4]],
  iconType                      = [[defenseraider]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  levelGround                   = false,
  losEmitHeight                 = 60,
  mass                          = 128,
  maxDamage                     = 785,
  maxSlope                      = 36,
  maxVelocity                   = 0,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  noChaseCategory               = [[FIXEDWING LAND SHIP SATELLITE SWIM GUNSHIP SUB HOVER]],
  objectName                    = [[lotustest2.s3o]],
  script                        = [[corllt.lua]],
  seismicSignature              = 4,
  selfDestructAs                = [[SMALL_BUILDINGEX]],

  sfxtypes                      = {

    explosiongenerators = {
      [[custom:BEAMWEAPON_MUZZLE_BLUE]],
    },

  },

  side                          = [[CORE]],
  sightDistance                 = 520,
  turnRate                      = 0,
  useBuildingGroundDecal        = true,
  waterline                     = 5,
  workerTime                    = 0,
  yardMap                       = [[oooo]],

  weapons                       = {

    {
      def                = [[LASER]],
      badTargetCategory  = [[FIXEDWING]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },

  },


  weaponDefs                    = {

    LASER = {
      name                    = [[Laserbeam]],
      areaOfEffect            = 8,
      beamTime                = 0.1,
      coreThickness           = 0.4,
      craterBoost             = 0,
      craterMult              = 0,

	  customparams = {
		stats_hide_damage = 1, -- continuous laser
		stats_hide_reload = 1,
	  },

      damage                  = {
        default = 7.15,
        subs    = 0.5,
      },

      explosionGenerator      = [[custom:FLASH1blue]],
      fireStarter             = 30,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      largeBeamLaser          = true,
      laserFlareSize          = 2,
      minIntensity            = 1,
      noSelfDamage            = true,
      range                   = 460,
      reloadtime              = 0.1,
      rgbColor                = [[0 1 1]],
      soundStart              = [[weapon/laser/laser_burn8]],
      soundTrigger            = true,
      sweepfire               = false,
      texture1                = [[largelaser]],
      texture2                = [[flare]],
      texture3                = [[flare]],
      texture4                = [[smallflare]],
      thickness               = 2,
      tolerance               = 5000,
      turret                  = true,
      weaponType              = [[BeamLaser]],
      weaponVelocity          = 500,
    },

  },


  featureDefs                   = {

    DEAD  = {
      description      = [[Wreckage - Lotus]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 785,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[20]],
      hitdensity       = [[100]],
      metal            = 36,
      object           = [[lotus_d.s3o]],
      reclaimable      = true,
      reclaimTime      = 36,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Lotus]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 785,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 18,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 18,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corllt = unitDef })
