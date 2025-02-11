unitDef = {
  unitname            = [[corgarp]],
  name                = [[Wolverine]],
  description         = [[Artillery Minelayer Vehicle]],
  acceleration        = 0.0282,
  brakeRate           = 0.08,
  buildCostEnergy     = 260,
  buildCostMetal      = 260,
  builder             = false,
  buildPic            = [[corgarp.png]],
  buildTime           = 260,
  canAttack           = true,
  canGuard            = true,
  canMove             = true,
  canPatrol           = true,
  category            = [[LAND]],
  corpse              = [[DEAD]],

  customParams        = {
    description_bp = [[Veiculo de artilharia]],
    description_fr = [[Vehicule Artilleur]],
	description_de = [[Artillerie Minenleger Fahrzeug]],
	description_pl = [[Pojazd - stawiacz min]],
    helptext       = [[The Wolverine lays mines which are fairly effective but have a limited lifespan (30s) from a distance (rather haphazardly). The Wolverine outranges most defenses comfortably, but is lightly armored and cannot flee easily so keep it screened with friendly units, possibly assisted by your own mines.]],
    helptext_bp    = [[Wolverine é o veículo de artilharia leve de Logos. Seus tiros s?o de alta trajetória ent?o n?o funciona bem contra unidades móveis. Seu alcançe supera com folga o de torres de laser pesadas, mas é pouco ágil e n?o pode atirar para trás, devendo ser protegido de agressores por linhas de unidades dispesadoras ou de assalto.]],
    helptext_fr    = [[Le Wolverine est l'arme idéale pour prendre d'assaut les zones fortifiées. Une grande portée, des tirs en cloche et une cadence de tir respectable en font une artillerie trcs bon marché. Peu rapide et ne pouvant pas tirer en arricre, il faudra cependant la protéger.]],
	helptext_de    = [[Der Wolverine legt Minen aus der Ferne, die ziemlich effektiv sind, aber nur eine begrenzte Lebensdauer (30s) besitzen. Er bedindet sich meist außerhalb der Reichweiten der Verteidigung, aber ist nur schwach gepanzert und kann nicht allzu schnell fliehen. Von daher begleite ihn lieber mit ein paar deiner Einheiten.]],
	helptext_pl    = [[Wolverine wystrzeliwuje na wyznaczony obszar miny, ktore pozostaja uzbrojone przez nastepne 30 sekund. Wolverine ma wiekszy zasieg niz wiekszosc wiezyczek, jednak z powodu bardzo niskiej wytrzymalosci wymaga wsparcia innych jednostek.]],
  },

  explodeAs           = [[BIG_UNITEX]],
  footprintX          = 3,
  footprintZ          = 3,
  highTrajectory      = 1,
  iconType            = [[vehiclearty]],
  idleAutoHeal        = 5,
  idleTime            = 1800,
  leaveTracks         = true,
  maneuverleashlength = [[650]],
  mass                = 151,
  maxDamage           = 450,
  maxSlope            = 18,
  maxVelocity         = 2.5,
  maxWaterDepth       = 22,
  minCloakDistance    = 75,
  movementClass       = [[TANK3]],
  moveState           = 0,
  noAutoFire          = false,
  noChaseCategory     = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP]],
  objectName          = [[corwolv.s3o]],
  seismicSignature    = 4,
  selfDestructAs      = [[BIG_UNITEX]],

  sfxtypes            = {

    explosiongenerators = {
      [[custom:wolvmuzzle0]],
      [[custom:wolvmuzzle1]],
      [[custom:wolvflash]],
    },

  },

  side                = [[CORE]],
  sightDistance       = 660,
  smoothAnim          = true,
  trackOffset         = 6,
  trackStrength       = 5,
  trackStretch        = 1,
  trackType           = [[StdTank]],
  trackWidth          = 30,
  turninplace         = 0,
  turnRate            = 399,
  workerTime          = 0,

  weapons             = {

    {
      def                = [[MINE]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },

  },


  weaponDefs          = {

    MINE = {
      name                    = [[Light Mine Artillery]],
      accuracy                = 1500,
      areaOfEffect            = 96,
      craterBoost             = 0,
      craterMult              = 0,

      customParams            = {
        damage_vs_shield = [[220]],
		spawns_name = "wolverine_mine",
		spawns_expire = 60,
      },
	  
      damage                  = {
        default = 20,
        planes  = 20,
        subs    = 0.5,
      },

      explosionGenerator      = [[custom:dirt]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      model                   = [[clawshell.s3o]],
      myGravity               = 0.34,
      noSelfDamage            = true,
      range                   = 730,
      reloadtime              = 5.5,
      soundHit                = [[weapon/cannon/wolverine_hit]],
      soundStart              = [[weapon/cannon/wolverine_fire]],
      startsmoke              = [[1]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 500,
    },

  },


  featureDefs         = {

    DEAD  = {
      description      = [[Wreckage - Wolverine]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 450,
      energy           = 0,
      featureDead      = [[DEAD2]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[0]],
      hitdensity       = [[100]],
      metal            = 104,
      object           = [[corwolv_dead.s3o]],
      reclaimable      = true,
      reclaimTime      = 104,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[all]],
    },


    DEAD2 = {
      description      = [[Debris - Wolverine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 450,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 104,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 104,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Wolverine]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 450,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 3,
      footprintZ       = 3,
      hitdensity       = [[100]],
      metal            = 52,
      object           = [[debris3x3c.s3o]],
      reclaimable      = true,
      reclaimTime      = 52,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ corgarp = unitDef })
