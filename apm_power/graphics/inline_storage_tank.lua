local base = '__apm_resource_pack_ldinc__/graphics/'
local sprites = base .. 'entities/inline_storage_tank/'

local shift = { 0.6875, -0.21875 }
local hr = {
    w = 320,
    h = 256,
    scale = 0.35,
}
local lr = {
    w = 160,
    h = 128,
    scale = 0.7,

}

return {
    icon = { icon = base .. "icons/apm_inline_storage_tank.png", icon_size = 64 },
    base = {
        lr = {
            path = sprites .. "base.png",
            w = lr.w,
            h = lr.h,
            scale = lr.scale,
            shift = shift,
        },
        hr = {
            path = sprites .. "hr_base.png",
            w = hr.w,
            h = hr.h,
            scale = hr.scale,
            shift = shift,
        },
    },
    shadow = {
        lr = {
            path = sprites .. "shadow.png",
            w = lr.w,
            h = lr.h,
            scale = lr.scale,
            shift = shift,
        },
        hr = {
            path = sprites .. "hr_shadow.png",
            w = hr.w,
            h = hr.h,
            scale = hr.scale,
            shift = shift,
        },
    },
    pipe_picture = {
        south = {
            filename = sprites .. "pipe-S.png",
            priority = "extra-high",
            width = 44,
            height = 31,
            shift = util.by_pixel(0, -31.5),
            hr_version = {
                filename = sprites .. "hr-pipe-S.png",
                priority = "extra-high",
                width = 88,
                height = 61,
                shift = util.by_pixel(0, -31.25),
                scale = 0.5
            }
        },
    },
}