unitDef = {
  unitname          = [[armsonar]],
  name              = [[Sonar Station]],
  description       = [[Locates Water Units]],
  activateWhenBuilt = true,
  buildCostEnergy   = 450,
  buildCostMetal    = 450,
  builder           = false,
  buildPic          = [[ARMSONAR.png]],
  buildTime         = 450,
  canAttack         = false,
  category          = [[UNARMED FLOAT]],
  collisionVolumeOffsets        = [[0 0 0]],
  collisionVolumeScales         = [[32 48 32]],
  collisionVolumeTest           = 1,
  collisionVolumeType           = [[CylY]],
  corpse            = [[DEAD]],
  energyUse         = 1.5,
  explodeAs         = [[SMALL_BUILDINGEX]],
  floater           = true,
  footprintX        = 2,
  footprintZ        = 2,
  iconType          = [[sonar]],
  idleAutoHeal      = 5,
  idleTime          = 1800,
  maxDamage         = 750,
  maxSlope          = 18,
  minCloakDistance  = 150,
  minWaterDepth     = 10,
  objectName        = [[novasonar.s3o]],
  onoffable         = true,
  script            = "armsonar.lua",
  seismicSignature  = 4,
  selfDestructAs    = [[SMALL_BUILDINGEX]],
  sightDistance     = 640,
  sonarDistance     = 1800,
  waterLine         = 0,
  yardMap           = [[oo oo]],
  
  customParams                  = {
    description_de = [[Ortet Einheiten unter Wasser]],
    description_pl = [[Wykrywa jednostki podwodne]],
    helptext       = [[The docile Sonar Station provides one of the few means of locating underwater targets.]],
    helptext_de    = [[Das Sonar ortet nach dem Echoprinzip von Radaranlagen feindliche Einheiten unter Wasser. Dazu strahlen sie selbst ein Signal aus und empfangen das entsprechende Echo, aus dessen Laufzeit auf die Entfernung zu den Einheiten geschlossen wird.]],
    helptext_pl    = [[Sonar jest odpowiednikiem radaru dzialajacym pod woda. Jest niezbedny do wykrywania (a zatem i niszczenia) okretow podwodnych i amfibii nieprzyjaciela.]],
    modelradius    = [[16]],
	removewait     = 1,
  },

  featureDefs       = {

    DEAD  = {
      description      = [[Wreckage - Sonar Station]],
      blocking         = false,
      damage           = 750,
      energy           = 0,
      featureDead      = [[HEAP]],
      footprintX       = 2,
      footprintZ       = 2,
      metal            = 180,
      object           = [[novasonar_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 180,
    },

    HEAP  = {
      description      = [[Debris - Sonar Station]],
      blocking         = false,
      damage           = 750,
      energy           = 0,
      footprintX       = 2,
      footprintZ       = 2,
      metal            = 90,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 90,
    },

  },

}

return lowerkeys({ armsonar = unitDef })
