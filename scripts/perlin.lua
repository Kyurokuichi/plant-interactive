-- Perlin noise generator
-- Implementation from kymckay (https://gist.github.com/kymckay/25758d37f8e3872e1636d90ad41fe2ed)
-- And flafla2 (http://flafla2.github.io/2014/08/09/perlinnoise.html)
-- Slightly modified by Yonichi

local perlin = {
    permutation = {},
}

-- Linear interpolation
local function lerp(a, b, t)
    return a + (b - a) * t
end

-- Fade function is used to smooth final output
local function fade(t)
    -- 6t^5 - 15t^4 + 10t^3
    -- t^3 (6t^2 - 15t + 10)
    -- t^3 (t(6t - 15) + 10) ; Simplified
    return t * t * t * (t * (6 * t - 15) + 10)
end

-- Gradient function finds dot product between pseudorandom gradient vector
-- and the vector from input coordinate to a unit cube vertex
local dotProduct = {
    [0x0]=function(x,y,z) return  x + y end,
    [0x1]=function(x,y,z) return -x + y end,
    [0x2]=function(x,y,z) return  x - y end,
    [0x3]=function(x,y,z) return -x - y end,
    [0x4]=function(x,y,z) return  x + z end,
    [0x5]=function(x,y,z) return -x + z end,
    [0x6]=function(x,y,z) return  x - z end,
    [0x7]=function(x,y,z) return -x - z end,
    [0x8]=function(x,y,z) return  y + z end,
    [0x9]=function(x,y,z) return -y + z end,
    [0xA]=function(x,y,z) return  y - z end,
    [0xB]=function(x,y,z) return -y - z end,
    [0xC]=function(x,y,z) return  y + x end,
    [0xD]=function(x,y,z) return -y + z end,
    [0xE]=function(x,y,z) return  y - x end,
    [0xF]=function(x,y,z) return -y - z end
}

local function gradient(hash, x, y, z)
    return dotProduct[bit.band(hash, 0xF)](x, y, z)
end

function perlin.generate()
    local exist = {}

    for i = 0, 255 do
        local value
        repeat
            value = math.random(0, 255) -- Generate random 8 bits value (0-255)
        until not exist[value]          -- Generate another value if the value has already been exists

        exist[value] = true             -- Check the value as existed number
        perlin.permutation[i] = value   -- Set the new value
        perlin.permutation[i+256] = value
    end
end

function perlin.noise(x, y, z)
    assert(x, 'value for x does not exist')

    y = y or 0
    z = z or 0

    -- Calculate the "unit cube" that the point asked will be located in
    local xi = bit.band(math.floor(x), 255)
    local yi = bit.band(math.floor(y), 255)
    local zi = bit.band(math.floor(z), 255)

    -- Next we calculate the location (from 0 to 1) in that cube
    x = x - math.floor(x)
    y = y - math.floor(y)
    z = z - math.floor(z)

    -- We also fade the location to smooth the result
    local u = fade(x)
    local v = fade(y)
    local w = fade(z)

    -- Hash all 8 unit cube coordinates surrounding input coordinate
    local permutation = perlin.permutation

    local A, AA, AB, AAA, ABA, AAB, ABB, B, BA, BB, BAA, BBA, BAB, BBB

    A   = permutation[xi    ] + yi
    AA  = permutation[A     ] + zi
    AB  = permutation[A+1   ] + zi
    AAA = permutation[AA    ]
    ABA = permutation[AB    ]
    AAB = permutation[AA+1  ]
    ABB = permutation[AB+1  ]

    B   = permutation[xi+1  ] + yi
    BA  = permutation[B     ] + zi
    BB  = permutation[B+1   ] + zi
    BAA = permutation[BA    ]
    BBA = permutation[BB    ]
    BAB = permutation[AB+1  ]
    BBB = permutation[BB+1  ]

    -- Take the weighted average between all 8 unit cube coordinates

    local y1 = lerp(
        lerp(gradient(AAA, x, y, z), gradient(BAA, x-1, y, z), u),
        lerp(gradient(ABA, x, y-1, z), gradient(BBA, x-1, y-1, z), u),
        v
    )

    local y2 = lerp(
        lerp(gradient(AAB, x, y, z-1), gradient(BAB, x-1, y, z-1), u),
        lerp(gradient(ABB, x, y-1, z-1), gradient(BBB, x-1, y-1, z-1), u),
        v
    )

    -- For convenience we bind the result to 0 - 1 (theoretical min/max before is [-1, 1])
    return (lerp(y1, y2, w) + 1)/2
end

return perlin