unitDef = {
  unitname                      = [[asteroid]],
  name                          = [[Asteroid]],
  description                   = [[Space Rock]],
  acceleration                  = 0,
  brakeRate                     = 0,
  buildCostEnergy               = 25,
  buildCostMetal                = 25,
  builder                       = false,
  buildPic                      = [[asteroid.png]],
  buildTime                     = 25,
  canAttack                     = false,
  category                      = [[SINK UNARMED]],
  corpse                        = [[DEAD]],
  footprintX                    = 2,
  footprintZ                    = 2,
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  isFeature                     = true,
  levelGround                   = false,
  mass                          = 86,
  maxDamage                     = 500,
  maxSlope                      = 255,
  maxVelocity                   = 0,
  maxWaterDepth                 = 0,
  minCloakDistance              = 150,
  objectName                    = [[asteroid.s3o]],
  script                        = [[asteroid.lua]],
  seismicSignature              = 4,
  sightDistance                 = 1,
  turnRate                      = 0,
  upright                       = false,
  workerTime                    = 0,
  yardMap                       = [[ff ff]],

  customParams        = {
	description_pl = [[Meteoryt]],
	helptext       = [[Asteroids can be manipulated to fall onto the planet by the Meteor Controller; they serve primarily as a weapon to crush the units they fall on, but they can also be reclaimed for resources.]],
	helptext_pl    = [[Asteroidy sciagniete z orbity miazdza jednostki, na ktore spadna; mozna z nich takze odzyskac surowce.]],
  },

  featureDefs                   = {

    DEAD = {
      description      = [[Asteroid]],
      blocking         = true,
      category         = [[dragonteeth]],
      damage           = 500,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[smudge01]],
      footprintX       = 3,
      footprintZ       = 3,
      height           = 20,
      hitdensity       = 100,
      metal            = 10,
      nodrawundergray  = true,
      object           = [[asteroid.s3o]],
      reclaimable      = true,
      reclaimTime      = 10,
      seqnamereclamate = [[tree1reclamate]],
      world            = [[allworld]],
    },
    
    HEAP  = {
      description      = [[Debris - Asteroid]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 500,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 5,
      object           = [[debris2x2b.s3o]],
      reclaimable      = true,
      reclaimTime      = 5,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },
    

  },

}

return lowerkeys({ asteroid = unitDef })
