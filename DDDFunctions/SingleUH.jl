#Computes a single unit hydrograph (UH) based on the distance distributions and the velocity

function SingleUH(k,Timeresinsec,meanD,maxD, nugget) 

#using Distributions   

#meanD: scalar float = 129.84
#maxD: scalar float = 538
#nugget: scalar float = 0.08
#Timeresinsec: scalar Integer = 86400
#k: scalar float, NB enters as an array float in other subroutines
    
ant = trunc(maxD/(k*Timeresinsec))+1
ant= Int(ant)    
UHvec = zeros(Float64,ant)

escl =  (meanD/k)/Timeresinsec 
Uhexp = Exponential(escl)    
UHvec[1] = (nugget+(1-nugget)*cdf(Uhexp,1)) #1/escl is parameter of distribution, escl is the mean of timesteps needed to drain.
if(ant > 1)
   for i in 2:ant
    UHvec[i] = (nugget+(1-nugget)*cdf(Uhexp,i))-(nugget+(1-nugget)*cdf(Uhexp,(i-1))) #Makes exponential pdf.  
                                           # UH is 1/e1ascl*exp(-(1/e1ascl)*t)/sum_for_all_t(1/e1ascl*exp(-(1/e1ascl)*t))
   end
end
UHvec[1:ant] = UHvec[1:ant]/sum(UHvec)                       #Must normalise so that the sum equals 1

return UHvec                                                 #Unit hydrograph, i.e. weights distributing runoff in time
end
