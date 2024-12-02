require 'util'

if not utils then utils = {} end
if not apm.lib.utils.pipecovers then apm.lib.utils.pipecovers = {} end

-- Pipecovers
function apm.lib.utils.pipecovers.assembler1pipepictures()
	return
	{
		north =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-1-pipe-N.png",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5
		},
		east =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-1-pipe-E.png",
			width = 42,
			height = 76,
			shift = util.by_pixel(-24.5, 1),
			scale = 0.5
		},
		south =
		{

			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-1-pipe-S.png",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5
		},
		west =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-1-pipe-W.png",
			width = 39,
			height = 73,
			shift = util.by_pixel(25.75, 1.25),
			scale = 0.5
		}
	}
end

function apm.lib.utils.pipecovers.assembler2pipepictures()
	return
	{
		north =
		{
			filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-pipe-N.png",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5,
		},
		east =
		{
			filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-pipe-E.png",
			width = 42,
			height = 76,
			shift = util.by_pixel(-24.5, 1),
			scale = 0.5,

		},
		south =
		{
			filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-pipe-S.png",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5,
		},
		west =
		{
			filename = "__base__/graphics/entity/assembling-machine-2/assembling-machine-2-pipe-W.png",
			width = 39,
			height = 73,
			shift = util.by_pixel(25.75, 1.25),
			scale = 0.5,
		}
	}
end

function apm.lib.utils.pipecovers.assembler3pipepictures()
	return
	{
		north =
		{
			filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-N.png",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5,
		},
		east =
		{
			filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-E.png",
			width = 42,
			height = 76,
			shift = util.by_pixel(-24.5, 1),
			scale = 0.5,
		},
		south =
		{
			filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-S.png",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5,
		},
		west =
		{
			filename = "__base__/graphics/entity/assembling-machine-3/assembling-machine-3-pipe-W.png",
			width = 39,
			height = 73,
			shift = util.by_pixel(25.75, 1.25),
			scale = 0.5,
		}
	}
end

function apm.lib.utils.pipecovers.assembler4pipepictures()
	return
	{
		north =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-4-pipe-N.png",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5,
		},
		east =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-4-pipe-E.png",
			width = 42,
			height = 76,
			shift = util.by_pixel(-24.5, 1),
			scale = 0.5,
		},
		south =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-4-pipe-S.png",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5,
		},
		west =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/pipecovers/hr-assembling-machine-4-pipe-W.png",
			width = 39,
			height = 73,
			shift = util.by_pixel(25.75, 1.25),
			scale = 0.5,
		}
	}
end

function apm.lib.utils.pipecovers.pipecoverspictures()
	return {
		north =
		{
			layers = {
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north.png",
					width = 128,
					height = 128,
					scale = 0.5
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-north-shadow.png",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true
				},
			},
		},
		east =
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-east.png",
					width = 128,
					height = 128,
					scale = 0.5
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-east-shadow.png",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true
				},
			},
		},
		south =
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south.png",
					width = 128,
					height = 128,
					scale = 0.5
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-south-shadow.png",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true
				},
			},
		},
		west =
		{
			layers =
			{
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-west.png",
					width = 128,
					height = 128,
					scale = 0.5
				},
				{
					filename = "__base__/graphics/entity/pipe-covers/pipe-cover-west-shadow.png",
					width = 128,
					height = 128,
					scale = 0.5,
					draw_as_shadow = true
				},
			},
		}
	}
end

function apm.lib.utils.pipecovers.nuclear_centrifuge_pipepictures()
	return
	{
		north =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/nuclear_centrifuge/pipe-N.png",
			width = 71,
			height = 38,
			shift = util.by_pixel(2.25, 13.5),
			scale = 0.5,
		},
		east =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/nuclear_centrifuge/pipe-E.png",
			width = 42,
			height = 76,
			shift = util.by_pixel(-24.5, 1),
			scale = 0.5,

		},
		south =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/nuclear_centrifuge/pipe-S.png",
			width = 88,
			height = 61,
			shift = util.by_pixel(0, -31.25),
			scale = 0.5,
		},
		west =
		{
			filename = "__apm_resource_pack_ldinc__/graphics/entities/nuclear_centrifuge/pipe-W.png",
			width = 39,
			height = 73,
			shift = util.by_pixel(25.75, 1.25),
			scale = 0.5,
		}
	}
end

function apm.lib.utils.pipecovers.frozen_pipe_cover_pictures()
	if not mods["space-age"] then
		return {}
	end

	return
	{
		north =
		{
			filename = "__space-age__/graphics/entity/frozen/pipe-covers/pipe-cover-north.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5
		},
		east =
		{
			filename = "__space-age__/graphics/entity/frozen/pipe-covers/pipe-cover-east.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5
		},
		south =
		{
			filename = "__space-age__/graphics/entity/frozen/pipe-covers/pipe-cover-south.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5
		},
		west =
		{
			filename = "__space-age__/graphics/entity/frozen/pipe-covers/pipe-cover-west.png",
			priority = "extra-high",
			width = 128,
			height = 128,
			scale = 0.5
		}
	}
end
