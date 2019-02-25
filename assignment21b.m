W = 2; %width of region y
L = 3; %Length of region x

BCsides = 1; 
BCtopbot = 0; %this is Vo

dx = 0.1;
dy = 0.1;
nx = L/dx;
ny = W/dy;

G = zeros(20*30,20*30);
F = zeros(nx*ny,1);

for i = 1:nx
    for j = 1:ny
        n = j+(i-1)*ny;
        
        if i == 1 
            G(n,n) = BCsides;
            F(n) = 1;
        elseif i == nx
            G(n,n) = BCsides;
        elseif j == 1
            G(n,n) = BCtopbot;
        elseif j == ny
            G(n,n) = BCtopbot;
        else
            nxm = j+(i-2)*ny;
            nxp = j+(i)*ny;
            nyp = j+1+(i-1)*ny;
            nym = j-1+(i-1)*ny;
            
            G(n,nxm) = 1/(dx^2);
            G(n,nxp) = 1/(dx^2);
            G(n,nym) = 1/(dy^2);
            G(n,nyp) = 1/(dy^2);
            G(n,n) = -2*(1/dx^2 + 1/dy^2);
        end
    end
end

V = G\F;
V = reshape(V,[],ny)';

Vmap = zeros(nx,ny);
for i = 1:nx
    for j = 1:ny
         n = j+(i-1)*ny;
         Vmap(i,j) = V(n);
    end
end

figure('Name','PartB')
surf(linspace(0,L,nx),linspace(0,W,ny),V);
%%surf(Vmap);
title(sprintf('Part b'));
xlabel('x');
ylabel('y');
