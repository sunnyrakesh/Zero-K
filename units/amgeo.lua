unitDef = {
  unitname                      = [[amgeo]],
  name                          = [[Moho Geothermal Powerplant]],
  description                   = [[Produces Energy (100) - HAZARDOUS]],
  acceleration                  = 0,
  activateWhenBuilt             = true,
  bmcode                        = [[0]],
  brakeRate                     = 0,
  buildAngle                    = 0,
  buildCostEnergy               = 1500,
  buildCostMetal                = 1500,
  builder                       = false,
  buildingGroundDecalDecaySpeed = 30,
  buildingGroundDecalSizeX      = 9,
  buildingGroundDecalSizeY      = 9,
  buildingGroundDecalType       = [[amgeo_aoplane.dds]],
  buildPic                      = [[AMGEO.png]],
  buildTime                     = 1500,
  category                      = [[SINK UNARMED]],
  collisionVolumeOffsets        = [[0 0 0]],
  collisionVolumeScales         = [[100 80 100]],
  collisionVolumeTest           = 1,
  collisionVolumeType           = [[ellipsoid]],
  corpse                        = [[DEAD]],

  customParams                  = {
    description_de = [[Erzeugt Energie (100) - RISKANT]],	
    helptext_de    = [[Das  Moho Geothermisches Kraftwerk erzeugt eine gro�e Menge an Energie, doch stellt es auch ein lohnendes Angriffsziel dar.]],
    pylonrange = 600,
  },

  energyMake                    = 100,
  energyUse                     = 0,
  explodeAs                     = [[NUCLEAR_MISSILE]],
  footprintX                    = 7,
  footprintZ                    = 7,
  iconType                      = [[energy3]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  mass                          = 419,
  maxDamage                     = 3250,
  maxSlope                      = 255,
  maxVelocity                   = 0,
  maxWaterDepth                 = 0,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[amgeo.obj]],
  script                        = [[amgeo.lua]],
  seismicSignature              = 4,
  selfDestructAs                = [[NUCLEAR_MISSILE]],
  side                          = [[ARM]],
  sightDistance                 = 273,
  smoothAnim                    = true,
  TEDClass                      = [[ENERGY]],
  turnRate                      = 0,
  useBuildingGroundDecal        = true,
  workerTime                    = 0,
  yardMap                       = [[ooooooo ooooooo ooGGGoo ooGGGoo ooGGGoo ooooooo ooooooo]],

  featureDefs                   = {

    DEAD  = {
      description      = [[Wreckage - Moho Geothermal Powerplant]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 1750,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[40]],
      hitdensity       = [[100]],
      metal            = 600,
      object           = [[amgeo_dead.obj]],
      reclaimable      = true,
      reclaimTime      = 600,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

    HEAP  = {
      description      = [[Debris - Moho Geothermal Powerplant]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 1750,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 4,
      footprintZ       = 4,
      height           = [[4]],
      hitdensity       = [[100]],
      metal            = 300,
      object           = [[debris4x4a.s3o]],
      reclaimable      = true,
      reclaimTime      = 300,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ amgeo = unitDef })
