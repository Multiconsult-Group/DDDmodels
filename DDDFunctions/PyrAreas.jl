#    Function PyrAreas
#
#------------------------------------------------------------------------
#     Description: Estimates the areas asscociated with each layer at ecach time step due to celerity
#                  A postprocessing routine
#
#     Author:  Thomas Skaugen
#     Revised: 17.12.2019
# See Skaugen and Mengistu(2016)for the rationale behind this subroutine
# Need to calculate the ratios. 
# the parameter gamma of the exponential distance distribution is 1/midDL
# From Skaugen and Mengistu, 2016 we have that the ratio Kappa is related to 
# gamma= -log(kappa)/delta_d, where delta_d is the distance interval of choice
# The ratio kappa is then kappa= exp(-gamma*delta_d)=exp(-delta_d/midDL) 
#--------------------------------------------------------------------------


function PyrAreas(NoL,totarea,maxDl,nodaysvector, layerUH, antHorlag)

# antHorlag: 1 dim array Integer
# layerUH: 2 dim array float
# nodaysvector: 1 dim array integer
# NoL: scalar, integer    
# maxDl: scalar, integer
# totarea: scalar, float
   
  # total area distributed pr Layer
  Areas = zeros(NoL,antHorlag)                      # matrix(0.0, ncol=antHorlag,nrow=NoL)
  for i in 1:NoL
  
    for j in 1:Int(nodaysvector[i])
       Areas[i,j] = totarea.*layerUH[i,j] 
    end
  end
  delta_d = zeros(NoL)                            # in meters (height as in the pyramid plots) pr. time-step box
  delta_d[1:NoL] = maxDl ./nodaysvector[1:NoL]  
  

#To be used in GRW_point subroutne: Layers__mm <- Layers*totarea/areas ######################
return Areas, delta_d
end

