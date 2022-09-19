#using Makie
using Plots
plotlyjs()
##
V(x,y) = x^2 + y^2
function F(x,y)
    Fx = -2*x
    Fy = -2*y
    return Fx,Fy
end
function Fint(xl,yl)
    x1, y1 = xl[1], yl[1]
    x2, y2 = xl[2], yl[2]
    wx,wy=5,5
    kx=500
    ky=500
    Fx = kx*exp(-wx*(x2 - x1)^2)*sign(x1-x2)
    Fy = ky*exp(-wy*(y2 - y1)^2)*sign(y1-y2)
    return Fx, Fy
end
##
dt =0.01
T = 0:dt:200
np = 50
X = zeros(length(T),np)
Y = zeros(length(T),np)
E = zeros(length(T))

m = ones(np)
Xinit = 20*randn(np)
Yinit = 20*randn(np)
Vxinit = 0*randn(np)
Vyinit = 0*randn(np)
##Iteration
xnew = Xinit
ynew = Yinit
vxnew = Vxinit
vynew = Vyinit
for i in 1:2070#length(T)
    fx, fy = F(xnew,ynew)
    fxt = copy(fx)
    fyt = copy(fy)
    for i in 1:length(xnew)
        for j in i+1:length(ynew)
            fxint,fyint = Fint([xnew[i],xnew[j]],[ynew[i],ynew[j]])
            fxt[i] += fxint
            fyt[i] += fyint
            fxt[j] += -fxint
            fyt[j] += -fyint
        end
    end
    xnew = xnew + vxnew*dt + 0.5*fxt*dt*dt./m
    ynew = ynew + vynew*dt + 0.5*fyt*dt*dt./m
    fxn, fyn = F(xnew, ynew)
    fxtn = copy(fxn)
    fytn = copy(fyn)
    for i in 1:length(xnew)
        for j in i:length(ynew)
            fxint,fyint = Fint([xnew[i],xnew[j]],[ynew[i],ynew[j]])
            fxtn[i] += fxint
            fytn[i] += fyint
            fxtn[j] += -fxint
            fytn[j] += -fyint

        end
    end
    vxnew = vxnew + 0.5*(fxt+fxtn)./m*dt
    vynew = vynew + 0.5*(fyt+fytn)./m*dt
    X[i,:] = xnew
    Y[i,:] = ynew
    E[i] = sum( (V.(xnew,ynew) + 0.5*m.*(vxnew.^2 + vynew.^2)) )
end
##
plot(E)
print(maximum(E)-minimum(E))
##
tjn=13
plot(X[:,tjn],Y[:,tjn])
##
#plot([-5,-5],[-5,5],linecolor=["black"])
#plot!([5,5],[-5,5],linecolor=["black"])
#plot!([-5,5],[5,5],linecolor=["black"])
#plot!([-5,5],[-5,-5],linecolor=["black"])
plot()
anim = @animate for i in 51:2060
    scatter([X[i,:]],[Y[i,:]],xlims=(-50,50),ylims=(-50,50),legend=false,dpi=500,color=:blue,axis=nothing)
    plot!([X[i-50:i,:]],[Y[i-50:i,:]],legend=false,dpi=500,color=:blue,axis=nothing)
end
##
gif(anim,"gas_High_repulsion.gif",fps=30)
