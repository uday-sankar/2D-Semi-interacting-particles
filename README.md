# 2D-Semi-interacting-particles
Animation code in julia for semi interacting particles in a 2D Well
The gas.jl contain  non interacting gas partciles in a well given by F(x,y) = x^2 + y^2.
Tha particles can pass over each other. so collissions are not considered. Just an interaction force is defined between any 2 particles
gas2.jl contains teh code for interacting gas particles. 
The code is not perfect.
Some particles seems have no interaction between them. Maybe something wrong with the way I have modeled the interaction.
The interaction energy is not considred when evaluating the total enrgy.
My aim was to find how the energy is being redistributed, and what state the system will go to after a long time. i.e understand the equilibriation of a very chaotic system.
I couldn't finish it, I got a bit busy.
