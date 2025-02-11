unitDef = {
  unitname               = [[chickenlandqueen]],
  name                   = [[Chicken Queen]],
  description            = [[Clucking Hell!]],
  acceleration           = 1,
  autoHeal               = 0,
  brakeRate              = 1,
  buildCostEnergy        = 0,
  buildCostMetal         = 0,
  builder                = false,
  buildPic               = [[chickenflyerqueen.png]],
  buildTime              = 40000,
  canAttack              = true,
  canGuard               = true,
  canMove                = true,
  canPatrol              = true,
  canstop                = [[1]],
  canSubmerge            = false,
  cantBeTransported      = true,
  category               = [[LAND]],
  collisionSphereScale   = 1,
  collisionVolumeOffsets = [[0 0 15]],
  collisionVolumeScales  = [[46 110 120]],
  collisionVolumeTest    = 1,
  collisionVolumeType    = [[box]],

  customParams           = {
    description_fr = [[Le mal incarn?!]],
	description_de = [[Lachende Höllenbrut!]],
	description_pl = [[Krolowa Kurnika]],
    helptext       = [[Two words: RUN AWAY! The Chicken Queen is the matriach of the Thunderbird colony, and when aggravated is virtually impossible to stop. It can spit fiery napalm, spray spores to kill aircraft, and kick land units away from it. Most of all, its jaws can rip apart the largest assault mech in seconds. Only the most determined, focused assault can hope to stop this beast in her tracks.]],
    helptext_fr    = [[Deux mots : FUIS MALHEUREUX ! La reine poulet est la matriarche de la colonie et une fois sa col?re attis?e elle est presque indestructible. Elle crache un acide extr?mement corrosif, largue des poulets et envoie des spores aux unit?s volantes. Seulement les assauts les plus brutaux et coordonn?s peuvent esp?rer venir ? bout de cette monstruosit?.]],
	helptext_de    = [[Zwei Worte: LAUF WEG! Die Chicken Queen ist die Matriarchin der Thunderbirdkolonie und sobald verärgert ist es eigentlich unmöglich sie noch zu stoppen. Sie kann kraftvolle Säure spucken, Landchicken abwerfen und Sporen gegen Lufteinheiten versprühen. Nur der entschlossenste und konzentrierteste Angriff kann es ermöglichen dieses Biest eventuell doch noch zu stoppen.]],
	helptext_pl    = [[Dwa slowa: W NOGI! Krolowa kolonii kurczakow moze zostac powstrzymana tylko dzieki pelnej determinacji i przy udziale wielkiej sily ognia; pluje plonacym kwasem, wystrzeliwuje mase zarodnikow, rozdeptuje mniejsze jednostki i jest w stanie rozszarpac nawet ciezkie roboty szturmowe.]],
  },

  explodeAs              = [[SMALL_UNITEX]],
  footprintX             = 8,
  footprintZ             = 8,
  iconType               = [[chickenq]],
  idleAutoHeal           = 5,
  idleTime               = 1800,
  leaveTracks            = true,
  mass                   = 4378,
  maxDamage              = 200000,
  maxVelocity            = 2.5,
  minCloakDistance       = 250,
  movementClass          = [[AKBOT6]],
  noAutoFire             = false,
  noChaseCategory        = [[TERRAFORM SATELLITE FIXEDWING GUNSHIP STUPIDTARGET MINE]],
  objectName             = [[chickenflyerqueen.s3o]],
  power                  = 65536,
  script                 = [[chickenlandqueen.lua]],
  seismicSignature       = 4,
  selfDestructAs         = [[SMALL_UNITEX]],

  sfxtypes               = {

    explosiongenerators = {
      [[custom:blood_spray]],
      [[custom:blood_explode]],
      [[custom:dirt]],
    },

  },

  side                   = [[THUNDERBIRDS]],
  sightDistance          = 2048,
  smoothAnim             = true,
  sonarDistance          = 450,
  trackOffset            = 18,
  trackStrength          = 8,
  trackStretch           = 1,
  trackType              = [[ChickenTrack]],
  trackWidth             = 100,
  turnRate               = 399,
  upright                = true,
  workerTime             = 0,

  weapons                = {

    {
      def                = [[MELEE]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 150,
      onlyTargetCategory = [[SWIM LAND SUB SINK TURRET FLOAT SHIP HOVER]],
    },


    {
      def                = [[FIREGOO]],
      mainDir            = [[0 0 1]],
      maxAngleDif        = 150,
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },


    {
      def                = [[SPORES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[SPORES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[SPORES]],
      onlyTargetCategory = [[FIXEDWING LAND SINK TURRET SHIP SWIM FLOAT GUNSHIP HOVER]],
    },


    {
      def                = [[QUEENCRUSH]],
      onlyTargetCategory = [[SWIM LAND SINK TURRET FLOAT SHIP HOVER]],
    },
	
    {
      def                = [[DODOBOMB]],
      onlyTargetCategory = [[NONE]],
    },


    {
      def                = [[BASILISKBOMB]],
      onlyTargetCategory = [[NONE]],
    },


    {
      def                = [[TIAMATBOMB]],
      onlyTargetCategory = [[NONE]],
    },
  },


  weaponDefs             = {
  
    BASILISKBOMB = {
      name                    = [[Basilisk Bomb]],
      accuracy                = 60000,
      areaOfEffect            = 48,
      avoidFeature            = false,
      avoidFriendly           = false,
      burnblow                = true,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,
      
      customparams            = {
      	spawns_name = "chickenc",
      	spawns_expire = 0,
      },

      damage                  = {
        default = 180,
      },

      explosionGenerator      = [[custom:none]],
      fireStarter             = 70,
      flightTime              = 0,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 0,
      manualBombSettings      = true,
      model                   = [[chickenc.s3o]],
      range                   = 500,
      reloadtime              = 10,
      renderType              = 1,
      smokedelay              = [[0.1]],
      smokeTrail              = false,
      startsmoke              = [[1]],
      startVelocity           = 200,
      tolerance               = 8000,
      tracks                  = false,
      turnRate                = 4000,
      turret                  = true,
      waterweapon             = true,
      weaponAcceleration      = 200,
      weaponTimer             = 0.1,
      weaponType              = [[AircraftBomb]],
      weaponVelocity          = 200,
    },


    DODOBOMB     = {
      name                    = [[Dodo Bomb]],
      accuracy                = 60000,
      areaOfEffect            = 1,
      avoidFeature            = false,
      avoidFriendly           = false,
      burnblow                = true,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,
      
      customparams            = {
      	spawns_name = "chicken_dodo",
      	spawns_expire = 30,
      },

      damage                  = {
        default = 1,
      },

      explosionGenerator      = [[custom:none]],
      fireStarter             = 70,
      flightTime              = 0,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 0,
      manualBombSettings      = true,
      model                   = [[chicken_dodobomb.s3o]],
      range                   = 500,
      reloadtime              = 10,
      renderType              = 1,
      smokedelay              = [[0.1]],
      smokeTrail              = false,
      startsmoke              = [[1]],
      startVelocity           = 200,
      tolerance               = 8000,
      tracks                  = false,
      turnRate                = 4000,
      turret                  = true,
      waterweapon             = true,
      weaponAcceleration      = 200,
      weaponTimer             = 0.1,
      weaponType              = [[AircraftBomb]],
      weaponVelocity          = 200,
    },

    TIAMATBOMB   = {
      name                    = [[Tiamat Bomb]],
      accuracy                = 60000,
      areaOfEffect            = 72,
      avoidFeature            = false,
      avoidFriendly           = false,
      burnblow                = true,
      collideFriendly         = false,
      craterBoost             = 1,
      craterMult              = 2,
      
      customparams            = {
      	spawns_name = "chicken_tiamat",
      	spawns_expire = 0,
      },

      damage                  = {
        default = 350,
      },

      explosionGenerator      = [[custom:none]],
      fireStarter             = 70,
      flightTime              = 0,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 0,
      manualBombSettings      = true,
      model                   = [[chickenbroodqueen.s3o]],
      noSelfDamage            = true,
      range                   = 500,
      reloadtime              = 10,
      renderType              = 1,
      smokedelay              = [[0.1]],
      smokeTrail              = false,
      startsmoke              = [[1]],
      startVelocity           = 200,
      tolerance               = 8000,
      tracks                  = false,
      turnRate                = 4000,
      turret                  = true,
      waterweapon             = true,
      weaponAcceleration      = 200,
      weaponTimer             = 0.1,
      weaponType              = [[AircraftBomb]],
      weaponVelocity          = 200,
    },	
	
    FIREGOO    = {
      name                    = [[Napalm Goo]],
      areaOfEffect            = 256,
      burst                   = 8,
      burstrate               = 0.01,
      cegTag                  = [[queen_trail_fire]],
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 400,
        planes  = 400,
        subs    = 2,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:napalm_koda]],
      firestarter             = 400,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      intensity               = 0.7,
      interceptedByShieldType = 1,
      lineOfSight             = true,
      noSelfDamage            = true,
      proximityPriority       = -4,
      range                   = 1200,
      reloadtime              = 6,
      renderType              = 4,
      rgbColor                = [[0.8 0.4 0]],
      size                    = 8,
      sizeDecay               = 0,
      soundHit                = [[weapon/burn_mixed]],
      soundStart              = [[chickens/bigchickenroar]],
      sprayAngle              = 6100,
      startsmoke              = [[0]],
      tolerance               = 5000,
      turret                  = true,
      weaponTimer             = 0.2,
      weaponType              = [[Cannon]],
      weaponVelocity          = 600,
    },


    MELEE      = {
      name                    = [[Chicken Claws]],
      areaOfEffect            = 32,
      craterBoost             = 1,
      craterMult              = 0,

      damage                  = {
        default = 1000,
        planes  = 1000,
        subs    = 1000,
      },

      endsmoke                = [[0]],
      explosionGenerator      = [[custom:NONE]],
      impulseBoost            = 0,
      impulseFactor           = 1,
      interceptedByShieldType = 0,
      lineOfSight             = true,
      noSelfDamage            = true,
      range                   = 200,
      reloadtime              = 1,
      size                    = 0,
      soundStart              = [[chickens/bigchickenbreath]],
      startsmoke              = [[0]],
      targetborder            = 1,
      tolerance               = 5000,
      turret                  = true,
      waterWeapon             = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 600,
    },


    QUEENCRUSH = {
      name                    = [[Chicken Kick]],
      areaOfEffect            = 400,
      collideFriendly         = false,
      craterBoost             = 0.001,
      craterMult              = 0.002,

      customParams           = {
	lups_noshockwave = "1",
      },
      
      
      damage                  = {
        default    = 10,
        chicken    = 0.001,
        planes     = 10,
        subs       = 5,
      },

      edgeEffectiveness       = 1,
      explosionGenerator      = [[custom:NONE]],
      impulseBoost            = 500,
      impulseFactor           = 1,
      intensity               = 1,
      interceptedByShieldType = 1,
      lineOfSight             = false,
      noSelfDamage            = true,
      range                   = 512,
      reloadtime              = 1,
      renderType              = 4,
      rgbColor                = [[1 1 1]],
      thickness               = 1,
      tolerance               = 100,
      turret                  = true,
      weaponType              = [[Cannon]],
      weaponVelocity          = 0.8,
    },


    SPORES     = {
      name                    = [[Spores]],
      areaOfEffect            = 24,
      avoidFriendly           = false,
      burst                   = 8,
      burstrate               = 0.1,
      collideFriendly         = false,
      craterBoost             = 0,
      craterMult              = 0,

      damage                  = {
        default = 75,
        planes  = [[150]],
        subs    = 7.5,
      },

      dance                   = 60,
      explosionGenerator      = [[custom:NONE]],
      fireStarter             = 0,
      flightTime              = 5,
      groundbounce            = 1,
      guidance                = true,
      heightmod               = 0.5,
      impactOnly              = true,
      impulseBoost            = 0,
      impulseFactor           = 0.4,
      interceptedByShieldType = 2,
      lineOfSight             = true,
      metalpershot            = 0,
      model                   = [[chickeneggpink.s3o]],
      noSelfDamage            = true,
      range                   = 600,
      reloadtime              = 4,
      renderType              = 1,
      selfprop                = true,
      smokedelay              = [[0.1]],
      smokeTrail              = true,
      startsmoke              = [[1]],
      startVelocity           = 100,
      texture1                = [[]],
      texture2                = [[sporetrail]],
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

  },

}

return lowerkeys({ chickenlandqueen = unitDef })
