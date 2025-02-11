unitDef = {
  unitname                      = [[tacnuke]],
  name                          = [[Eos]],
  description                   = [[Tactical Nuke]],
  buildCostEnergy               = 600,
  buildCostMetal                = 600,
  builder                       = false,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 3,
  buildingGroundDecalSizeY      = 3,
  buildingGroundDecalType       = [[tacnuke_aoplane.dds]],
  buildPic                      = [[tacnuke.png]],
  buildTime                     = 600,
  canAttack                     = true,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 25 0]],
  collisionVolumeScales         = [[20 60 20]],
  collisionVolumeTest	        = 1,
  collisionVolumeType	        = [[CylY]],

  customParams                  = {
    description_fr = [[Lance Missile Nucléaire Tactique]],
    description_de = [[Taktische Rakete]],
    description_pl = [[Rakieta taktyczna]],
    helptext       = [[A long-range precision strike weapon. The Eos' blast radius is small, but lethal.]],
    helptext_fr    = [[Le Eos est un lance missile nucléaire tactique. Les tetes nucléaires ne sont pas aussi lourdes que celles du Silencer et la portée moindre. Mais bien placé, il peut faire des ravages, et présente un rapport cout/efficacité plus qu'interressant.]],
    helptext_de    = [[Eine weitreichende, präzise Waffe. Die Druckwelle ist zwar klein, aber tödlich.]],
    helptext_pl    = [[Jednorazowa rakieta dalekiego zasiegu, ktorej wybuch obejmuje maly obszar, lecz jest bardzo silny.]],
    mobilebuilding = [[1]],
  },

  explodeAs                     = [[WEAPON]],
  footprintX                    = 1,
  footprintZ                    = 1,
  iconType                      = [[cruisemissilesmall]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  maxDamage                     = 1000,
  maxSlope                      = 18,
  minCloakDistance              = 150,
  objectName                    = [[wep_tacnuke.s3o]],
  script                        = [[cruisemissile.lua]],
  seismicSignature              = 4,
  selfDestructAs                = [[WEAPON]],

  sfxtypes                      = {

    explosiongenerators = {
      [[custom:RAIDMUZZLE]],
    },

  },

  sightDistance                 = 0,
  useBuildingGroundDecal        = false,
  yardMap                       = [[o]],

  weapons                       = {

    {
      def                = [[WEAPON]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER GUNSHIP]],
    },

  },

  weaponDefs                    = {

    WEAPON = {
      name                    = [[Tactical Nuke]],
      areaOfEffect            = 192,
      avoidFriendly           = false,
      cegTag                  = [[tactrail]],
      collideFriendly         = false,
      craterBoost             = 4,
      craterMult              = 3.5,
	  
      customParams            = {
      lups_explodelife = 1.5,
	  },
	  
      damage                  = {
        default = 3502.5,
        subs    = 175,
      },

      edgeEffectiveness       = 0.4,
      explosionGenerator      = [[custom:NUKE_150]],
      fireStarter             = 0,
      flightTime              = 20,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      levelGround             = false,
      model                   = [[wep_tacnuke.s3o]],
      range                   = 3500,
      reloadtime              = 10,
      shakeduration           = [[1.5]],
      shakemagnitude          = [[32]],
      smokeTrail              = false,
      soundHit                = [[explosion/mini_nuke]],
      soundStart              = [[weapon/missile/tacnuke_launch]],
      tolerance               = 4000,
      turnrate                = 18000,
      weaponAcceleration      = 180,
      weaponTimer             = 3,
      weaponType              = [[StarburstLauncher]],
      weaponVelocity          = 1200,
    },

  },

  featureDefs                   = {
  },

}

return lowerkeys({ tacnuke = unitDef })
