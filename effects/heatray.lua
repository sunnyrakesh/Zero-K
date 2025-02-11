-- heatray_ceg
-- heatray_hit

return {
  ["heatray_ceg"] = {
    light = {
      air                = true,
      class              = [[CSimpleGroundFlash]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        colormap           = [[1 0.5 0 0.03  0 0 0 0.01]],
        size               = 80,
        sizegrowth         = 0,
        texture            = [[groundflash]],
        ttl                = 5,
      },
    },
  },

  ["heatray_hit"] = {
    usedefaultexplosions = false,
    cinder = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = false,
        heat               = [[d1 5]],
        heatfalloff        = 1,
        maxheat            = 15,
        pos                = 0,
        size               = [[5]],
        sizegrowth         = -0.05,
        speed              = [[0, 0, 0]],
        texture            = [[redexplo]],
      },
    },
    airflash = {
      air                = true,
      class              = [[heatcloud]],
      count              = 1,
      ground             = true,
      water              = true,
      properties = {
        alwaysvisible      = false,
        heat               = [[d1 5]],
        heatfalloff        = 2,
        maxheat            = 15,
        pos                = 0,
        size               = [[3]],
        sizegrowth         = 1,
        speed              = [[0, 0, 0]],
        texture            = [[redexplo]],
      },
    },
    groundflash = {
      circlealpha        = 1,
      circlegrowth       = 0.125,
      flashalpha         = 0.5,
      flashsize          = 8,
      ttl                = 64,
      color = {
        [1]  = 1,
        [2]  = 0.25,
        [3]  = 0,
      },
    },
    sparks = {
      class              = [[CSimpleParticleSystem]],
      count              = 1,
      ground             = true,
      unit               = 1,
      properties = {
        airdrag            = 0.999,
        alwaysvisible      = false,
        colormap           = [[1 0.75 0.25 0.01   0.01 0.01 0.005 0.01]],
        directional        = true,
        emitrot            = 180,
        emitrotspread      = 80,
        emitvector         = [[dir]],
        gravity            = [[0, -1, 0]],
        numparticles       = [[d1 5]],
        particlelife       = [[d5 10]],
        particlelifespread = 2,
        particlesize       = [[d0.1 0.5]],
        particlesizespread = 0.5,
        particlespeed      = [[0.5 d0.1]],
        particlespeedspread = 2,
        pos                = [[0, 0, 0]],
        sizegrowth         = 0,
        sizemod            = 0.9,
        texture            = [[plasma]],
      },
    },
    steam = {
      class              = [[CExpGenSpawner]],
      count              = 2,
      nounit             = 1,
      properties = {
        delay              = [[i1]],
        dir                = [[dir]],
        explosiongenerator = [[custom:BEAMWEAPON_HIT_YELLOW_STEAM]],
        pos                = [[0, 0, 0]],
      },
    },
  },

}

