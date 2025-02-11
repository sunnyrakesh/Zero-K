unitDef = {
  unitname               = [[trem]],
  name                   = [[Tremor]],
  description            = [[Heavy Saturation Artillery Tank]],
  acceleration           = 0.05952,
  brakeRate              = 0.124,
  buildCostEnergy        = 1500,
  buildCostMetal         = 1500,
  builder                = false,
  buildPic               = [[TREM.png]],
  buildTime              = 1500,
  canAttack              = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canstop          	      = [[1]],
  category               = [[LAND]],
  collisionVolumeOffsets = [[0 0 0]],
  collisionVolumeScales  = [[34 34 50]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[cylZ]],
  corpse                 = [[DEAD]],

  customParams           = {
    description_de = [[Schwerer Saturation Artillerie Panzer]],
    description_bp = [[Tanque de artilharia pesado]],
    description_fr = [[Artillerie Lourde]],
    description_pl = [[Ciezka artyleria]],
    helptext       = [[The principle behind the Tremor is simple: flood an area with enough shots, and you'll hit something at least once. Slow, clumsy, vulnerable and extremely frightening, the Tremor works best against high-density target areas, where its saturation shots are most likely to do damage. It pulverizes shields in seconds and its shells smooth terrain.]],
    helptext_bp    = [[O princípio por trás do Tremor é simples: encha uma área com tiros suficientes, e voç? acertará algo pelo menos uma vez. Lento, atrapalhado, vulnerável e extremamente assustador, Tremor funciona melhor contra áreas-alvo de alta densidade, onde seus tiros de saturaç?o tem maior probabilidade de causar dano.]],
    helptext_fr    = [[Le principe du Tremor est simple: inonder une zone de tirs plasma gr?ce ? son triple canon, avec une chance de toucher quelquechose. Par d?finition impr?cis, le Tremor est l'outil indispensable de destruction de toutes les zones ? h'aute densit? d'ennemis.]],
	helptext_de    = [[Das Prinzip hinter dem Tremor ist einfach: flute ein Areal mit genug Schüssen und du wirst irgendwas, wenigstens einmal, treffen. Langsam, schwerfällig, anfällig und extrem beängstigend ist der Tremor, weshalb er gegen dichbesiedelte Gebiete sinnvoll einzusetzen ist.]],
	helptext_pl    = [[Tremor zalewa okolice gradem pociskow, co doskonale sprawdza sie przeciwko duzym zgrupowaniom wrogich jednostek i tarczom i wyrownuje teren.]],
	modelradius    = [[17]],
  },

  explodeAs              = [[BIG_UNIT]],
  footprintX             = 4,
  footprintZ             = 4,
  highTrajectory         = 1,
  iconType               = [[tanklrarty]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  leaveTracks            = true,
  mass                   = 392,
  maxDamage              = 2045,
  maxSlope               = 18,
  maxVelocity            = 1.7,
  maxWaterDepth          = 22,
  minCloakDistance       = 75,
  movementClass          = [[TANK4]],
  moveState              = 0,
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM FIXEDWING SATELLITE GUNSHIP]],
  objectName             = [[cortrem.s3o]],
  seismicSignature       = 4,
  selfDestructAs         = [[BIG_UNIT]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:wolvmuzzle1]],
    },

  },

  side                   = [[CORE]],
  sightDistance          = 660,
  smoothAnim             = true,
  trackOffset            = 20,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[StdTank]],
  trackWidth             = 38,
  turninplace            = 0,
  turnRate               = 312,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[PLASMA]],
      badTargetCategory  = [[SWIM LAND SHIP HOVER]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 270,
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },

  },


  weaponDefs             = {

    PLASMA = {
      name                    = [[Rapid-Fire Plasma Artillery]],
      accuracy                = 1400,
      areaOfEffect            = 160,
	  avoidFeature            = false,
	  avoidGround             = false,
      craterBoost             = 0,
      craterMult              = 0,
	  
	  customParams            = {
	    gatherradius     = [[192]],
	    smoothradius     = [[96]],
		smoothmult       = [[0.25]],
		lups_noshockwave = [[1]],
	  },
	  
      damage                  = {
        default = 135,
        planes  = 135,
        subs    = 7,
      },
	  
      explosionGenerator      = [[custom:tremor]],
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 1,
      myGravity               = 0.1,
      range                   = 1300,
      reloadtime              = 0.36,
      soundHit                = [[weapon/cannon/cannon_hit2]],
      soundStart              = [[weapon/cannon/tremor_fire]],
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 420,
    },

  },


  featureDefs            = {

    DEAD  = {
      description      = [[Wreckage - Tremor]],
      blocking         = true,
      category         = [[corpses]],
      damage           = 2045,
      energy           = 0,
      featureDead      = [[HEAP]],
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[8]],
      hitdensity       = [[100]],
      metal            = 600,
      object           = [[tremor_dead_new.s3o]],
      reclaimable      = true,
      reclaimTime      = 600,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },


    HEAP  = {
      description      = [[Debris - Tremor]],
      blocking         = false,
      category         = [[heaps]],
      damage           = 2045,
      energy           = 0,
      featurereclamate = [[SMUDGE01]],
      footprintX       = 2,
      footprintZ       = 2,
      height           = [[2]],
      hitdensity       = [[100]],
      metal            = 300,
      object           = [[debris2x2a.s3o]],
      reclaimable      = true,
      reclaimTime      = 300,
      seqnamereclamate = [[TREE1RECLAMATE]],
      world            = [[All Worlds]],
    },

  },

}

return lowerkeys({ trem = unitDef })
