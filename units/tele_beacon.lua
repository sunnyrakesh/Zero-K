unitDef = {
  unitname                      = [[tele_beacon]],
  name                          = [[Lamp]],
  description                   = [[Teleport Bridge Entry Beacon, right click to teleport.]],
  acceleration                  = 0,
  brakeRate                     = 0,
  buildAngle                    = 4096,
  buildCostEnergy               = 800,
  buildCostMetal                = 800,
  builder                       = false,
  buildTime                     = 800,
  category                      = [[SINK UNARMED]],

  customParams                  = {
	helptext       = [[This is Djinn's entry beacon. Right-click it to teleport units to the parent Djinn.]],
	description_de = [[Teleport-Knoten - rechten Maustaste darauf]],
	description_pl = [[Wezel teleportera - uzyj prawego przycisku myszy]],
	helptext_de    = [[Dieser Teleport-Knoten teleportiert Einheiten zu der verknuepften Djinn.]],
	helptext_pl    = [[To jest wejscie do teleportera - uzyj prawego przycisku myszy, aby przeteleportowac jednostki do powiazanego Djinna.]],
  	dontcount = [[1]],
  },

  energyUse                     = 0,
  explodeAs                     = [[TINY_BUILDINGEX]],
  footprintX                    = 2,
  footprintZ                    = 2,
  levelGround                   = false,
  iconType                      = [[statictransport]],
  idleAutoHeal                  = 5,
  idleTime                      = 1800,
  mass                          = 336,
  maxDamage                     = 1500,
  maxSlope                      = 18,
  maxVelocity                   = 0,
  minCloakDistance              = 150,
  noAutoFire                    = false,
  objectName                    = [[amphteleportbeacon.s3o]],
  power							= 100,
  reclaimable					= false,
  script                		= [[tele_beacon.lua]],
  seismicSignature              = 4,
  selfDestructAs                = [[TINY_BUILDINGEX]],
  selfDestructCountdown			= 5,
  side                          = [[ARM]],
  sightDistance                 = 0,
  turnRate                      = 0,
  useBuildingGroundDecal        = false,
  workerTime                    = 0,
  --yardMap                       = [[oooooooooooooooooooo]],

  featureDefs                   = {
  },

}

return lowerkeys({ tele_beacon = unitDef })
