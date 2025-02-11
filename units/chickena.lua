unitDef = {
  unitname            = [[chickena]],
  name                = [[Cockatrice]],
  description         = [[Assault/Anti-Armor]],
  acceleration        = 0.36,
  brakeRate           = 0.205,
  buildCostEnergy     = 0,
  buildCostMetal      = 0,
  builder             = false,
  buildPic            = [[chickena.png]],
  buildTime           = 350,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND]],

  customParams        = {
    description_fr = [[Unit? lourde de m?l?e]],
	description_de = [[Sturm/Anti-Panzerung]],
	description_pl = [[Kurczak szturmowy/przeciwpancerny]],
    helptext       = [[The Cockatrice is truly a beast. Seemingly impervious to enemy fire, it casually walks up to its target and dismembers it with its incredibly powerful jaws. Fortunately, it is not fast or particularly intelligent, and can be destroyed with skirmishers or swarmers easily.]],
    helptext_fr    = [[Le Cockatrice est un v?ritale monstre. Apparament insensible aux feu adverse it charge sans ralentir sa cible et la d?membre avec ses lentes mais puissantes machoires d?mesur?es. Heuresement il n'est pas tr?s rapide ni intelligent et peut dont ?tre abattu relativement ais?ment par des essaims ou des unit?s ? longue port?e.]],
	helptext_de    = [[Der Cockatrice ist wahrlich eine Bestie. Scheinbar unverletzlich, bewegt es sich einfach auf seine Ziele zu und zerstückelt sie vor Ort mit seinem unglaublich starken Kiefer. Glücklicherweise ist er nicht besonders schnell und intelligent und kann somit von Skirmishern und Schwärmen leicht zerstört werden.]],
	helptext_pl    = [[Cockatrice to wytrzymala bestia, ktora powoli podchodzi do celu i rozczlonkowuje go przeogromnymi szczekami. Nie grzeszy inteligencja ani szybkostrzelnoscia.]],
  },

  explodeAs           = [[NOWEAPON]],
  footprintX          = 4,
  footprintZ          = 4,
  iconType            = [[chickena]],
  idleAutoHeal        = 20,
  idleTime            = 300,
  leaveTracks         = true,
  mass                = 261,
  maxDamage           = 2800,
  maxSlope            = 37,
  maxVelocity         = 1.8,
  maxWaterDepth       = 5000,
  minCloakDistance    = 75,
  movementClass       = [[AKBOT6]],
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP SUB MINE]],
  objectName          = [[chickena.s3o]],
  power               = 420,
  seismicSignature    = 4,
  selfDestructAs      = [[NOWEAPON]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },

  side                = [[THUNDERBIRDS]],
  sightDistance       = 256,
  smoothAnim          = true,
  trackOffset         = 7,
  trackStrength       = 9,
  trackStretch        = 1,
  trackType           = [[ChickenTrack]],
  trackWidth          = 34,
  turnRate            = 806,
  upright             = false,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[WEAPON]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 120,
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER FIXEDWING GUNSHIP]],
    },

  },


  weaponDefs          = {

    AEROSPORES = {
      name                    = [[Anti-Air Spores]],
      areaOfEffect            = 24,
      avoidFriendly           = false,
      burst                   = 5,
      burstrate               = 0.15,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,

      damage                  = {
        default = 80,
        planes  = 80,
        subs    = 8,
      },

      dance                   = 60,
      explosionGenerator      = [[custom:NONE]],
      fireStarter             = 0,
      fixedlauncher           = 1,
      flightTime              = 5,
      groundbounce            = 1,
      guidance                = true,
      heightmod               = 0.5,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[chickeneggblue.s3o]],
      noSelfDamage            = true,
      range                   = 600,
      reloadtime              = 8,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      startsmoke              = [[1]],
      startVelocity           = 100,
      texture1                = [[]],
      texture2                = [[sporetrailblue]],
      tolerance               = 10000,
      tracks                  = true,
      turnRate                = 24000,
      turret                  = true,
      waterweapon             = true,
      weaponAcceleration      = 100,
      weaponType              = [[MissileLauncher]],
      weaponVelocity          = 500,
      wobble                  = 32000,
    },


    WEAPON     = {
      name                    = [[Claws]],
      areaOfEffect            = 8,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 1700,
        planes  = 1700,
        subs    = 6,
      },

      explosionGenerator      = [[custom:NONE]],
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 0,
      noSelfDamage            = true,
      range                   = 140,
      reloadtime              = 7,
      size                    = 0,
      soundHit                = [[chickens/chickenbig2]],
      soundStart              = [[chickens/chickenbig2]],
      targetborder            = 1,
      tolerance               = 5000,
      turret                  = true,
      waterWeapon             = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 1000,
    },

  },

}

return lowerkeys({ chickena = unitDef })
