#    Function Layer_capacity
#
#------------------------------------------------------------------------
#     Description:  Calculates current capacity in groundwater layers. 
#
#     Author: Thomas Skaugen
#     Revised: 16.12.2019
#--------------------------------------------------------------------------

function LayerCapacityUpdate(Layers, nodaysvector, Magkap, NoL)

ddistx = zeros(Float64,NoL)
aktMag = zeros(Float64,NoL)

#Below are the states (in mm) for each saturation level
for j in reverse(1:NoL)
                                      #state after this timesteps' water is gone. amount of water  in mm, minus current timestep
  aktMag[j] = sum(Layers[j,2:nodaysvector[j]])

  if (aktMag[j] < Magkap[j])
   ddistx[j] = Magkap[j] - aktMag[j]
  end
        
end

return ddistx  # ddistx informs on current capacity for each level in mm.
end

