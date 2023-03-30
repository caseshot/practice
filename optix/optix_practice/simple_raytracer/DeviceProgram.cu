// ======================================================================== //
// Copyright 2018-2019 Ingo Wald                                            //
//                                                                          //
// Licensed under the Apache License, Version 2.0 (the "License");          //
// you may not use this file except in compliance with the License.         //
// You may obtain a copy of the License at                                  //
//                                                                          //
//     http://www.apache.org/licenses/LICENSE-2.0                           //
//                                                                          //
// Unless required by applicable law or agreed to in writing, software      //
// distributed under the License is distributed on an "AS IS" BASIS,        //
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. //
// See the License for the specific language governing permissions and      //
// limitations under the License.                                           //
// ======================================================================== //

#include <optix_device.h>
#include <vector>

#include "LaunchParams.h"

/*! launch parameters in constant memory, filled in by optix upon
    optixLaunch (this gets filled in from the buffer we pass to
    optixLaunch) */
extern "C" __constant__ LaunchParams g_optix_launch_params;

//------------------------------------------------------------------------------
// closest hit and anyhit programs for radiance-type rays.
//
// Note eventually we will have to create one pair of those for each
// ray type and each geometry type we want to render; but this
// simple example doesn't use any actual geometries yet, so we only
// create a single, dummy, set of them (we do have to have at least
// one group of them to set up the SBT)
//------------------------------------------------------------------------------

extern "C" __global__ void
__closesthit__radiance()
{ /*! for this simple example, this will remain empty */
}

extern "C" __global__ void
__anyhit__radiance()
{ /*! for this simple example, this will remain empty */
}

//------------------------------------------------------------------------------
// miss program that gets called for any ray that did not have a
// valid intersection
//
// as with the anyhit/closest hit programs, in this example we only
// need to have _some_ dummy function to set up a valid SBT
// ------------------------------------------------------------------------------

extern "C" __global__ void
__miss__radiance()
{ /*! for this simple example, this will remain empty */
}

//------------------------------------------------------------------------------
// ray gen program - the actual rendering happens in here
//------------------------------------------------------------------------------
extern "C" __global__ void
__raygen__renderFrame()
{
    if (g_optix_launch_params.frame_id == 0 && optixGetLaunchIndex().x == 0 && optixGetLaunchIndex().y == 0) {
        // we could of course also have used optixGetLaunchDims to query
        // the launch size, but accessing the g_optix_launch_params here
        // makes sure they're not getting optimized away (because
        // otherwise they'd not get used)
        printf("############################################\n");
        printf("Hello world from OptiX 7 raygen program!\n(within a %ix%i-sized launch)\n",
               g_optix_launch_params.size.width,
               g_optix_launch_params.size.height);
        printf("############################################\n");
    }

    // ------------------------------------------------------------------
    // for this example, produce a simple test pattern:
    // ------------------------------------------------------------------

    // compute a test pattern based on pixel ID
    const int ix       = optixGetLaunchIndex().x;
    const int iy       = optixGetLaunchIndex().y;

    const int frame_id = g_optix_launch_params.frame_id;
    const int r        = ((ix + frame_id) % 256);
    const int g        = ((iy + frame_id) % 256);
    const int b        = 0;

    // convert to 32-bit rgba value (we explicitly set alpha to 0xff
    // to make stb_image_write happy ...
    const uchar4 rgba = { (uint8_t) r, (uint8_t) g, (uint8_t) b, 0xff };

    // and write to frame buffer ...
    const uint32_t fbIndex                      = ix + iy * g_optix_launch_params.size.width;
    g_optix_launch_params.color_buffer[fbIndex] = rgba;
}