#using Makie
using Plots
#plotlyjs()
##
V(x,y) = x^2 + y^2
function F(x,y)
    Fx = -2*x
    Fy = -2*y
    return Fx,Fy
end
m = 1
xinit = 2
yinit = 3
vxinit = -8
vyinit = 2
dt =0.1
T = 0:dt:10
X = zeros(length(T))
Y = zeros(length(T))
##Iteration
xnew = xinit
ynew = yinit
vxnew = vxinit
vynew = vyinit
for i in 1:length(T)
    Fx, Fy =F(xnew, ynew)
    xnew = xnew + vxnew*dt + 0.5*Fx*dt*dt/m
    ynew = ynew + vynew*dt + 0.5*Fy*dt*dt/m
    vxnew = vxnew + Fx*dt/m
    vynew = vynew + Fy*dt/m
    X[i] = xnew
    Y[i] = ynew
end
##
#plot([-5,-5],[-5,5],linecolor=["black"])
#plot!([5,5],[-5,5],linecolor=["black"])
#plot!([-5,5],[5,5],linecolor=["black"])
#plot!([-5,5],[-5,-5],linecolor=["black"])
anim = @animate for i=1:length(X)
    scatter!([X[i]],[Y[i]],legend=false,dpi=500,linecolor=["blue"])
    end
##
gif(anim,"anim1.gif",fps=30)
