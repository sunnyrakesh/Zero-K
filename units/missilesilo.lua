unitDef = {
  unitname                      = [[missilesilo]],
  name                          = [[Missile Silo]],
  description                   = [[Produces Missiles, Builds at 10 m/s]],
  acceleration                  = 0,
  brakeRate                     = 0,
  buildCostEnergy               = 1200,
  buildCostMetal                = 1200,
  builder                       = true,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 6,
  buildingGroundDecalSizeY      = 6,
  buildingGroundDecalType       = [[missilesilo_aoplane.dds]],

  buildoptions                  = {
    [[tacnuke]],
    [[seismic]],
    [[empmissile]],
    [[napalmmissile]],
  },

  buildPic                      = [[missilesilo.png]],
  buildTime                     = 1200,
  canAttack                     = true,
  canFight                      = false,
  canMove                       = false,
  canPatrol                     = false,
  canstop                       = [[1]],
  category                      = [[SINK UNARMED]],
  collisionVolumeTest           = 1,
  corpse                        = [[DEAD]],

  customParams                  = {
    description_de = [[Produziert Raketen, Baut mit 10 M/s]],
    helptext       = [[The Missile Silo constructs and holds up to four different cruise missiles, each with a unique warhead. It offers excellent standoff strike capability for offensive and defensive purposes.]],
	helptext_de    = [[Das Raketensilo erzeugt und lagert bis zu vier verschiedene Marschflugkörper, jede mit einem einzigartigen Sprengkopf. Das Silo bietet hervorragende Schlagkraft in Pattsituationen, sowohl für offensive, als auch defensive Zwecke.]],
  },

  energyMake                    = 0.3,
  energyUse                     = 0,
  explodeAs                     = [[LARGE_BUILDINGEX]],
  fireState                     = 0,
  footprintX                    = 6,
  footprintZ                    = 6,
  iconType                      = [[cruisemissile]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  mass                          = 403,
  maxDamage                     = 4000,
  maxSlope                      = 15,
  maxVelocity                   = 0,
  maxWaterDepth                 = 0,
  metalMake                     = 0.3,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[missilesilo.s3o]],
  script						= [[missilesilo.lua]],
  seismicSignature              = 4,
  selfDestructAs                = [[LARGE_BUILDINGEX]],
  showNanoSpray                 = false,
  side                          = [[ARM]],
  sightDistance                 = 273,
  TEDClass                      = [[PLANT]],
  turnRate                      = 0,
  useBuildingGroundDecal        = true,
  workerTime                    = 10,
  yardMap                       = [[oooooo occcco occcco occcco occcco oooooo]],

  featureDefs                   = {

    DEAD = {
      description      = [[Wreckage - Missile Silo]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 4000,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 6,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 480,
      object           = [[missilesilo_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 480,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP = {
      description      = [[Debris - Missile Silo]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 4000,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 5,
      footprintZ       = 5,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 240,
      object           = [[debris4x4c.s3o]],
      reclaimable      = true,
      reclaimTime      = 240,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ missilesilo = unitDef })
