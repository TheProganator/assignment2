W = 2; %width of region y
L = 3; %Length of region x

BCleft = 0; 
BCright = 1; %this is Vo

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
            G(n,n) = BCleft;
            F(n) = 1;
        elseif i == nx
            G(n,n) = BCright;
        elseif j == 1
          %  nxm = j+(i-2)*ny;
          %  nxp = j+(i)*ny;
            nyp = j+1+(i-1)*ny;
            
          %  G(n,nxm) = 1;
           % G(n,nxp) = 1;
            G(n,nyp) = -1;
            G(n,n) = 1;
        elseif j == ny
         %   nxm = j+(i-2)*ny;
          %  nxp = j+(i)*ny;
            nym = j-1+(i-1)*ny;
            
     %       G(n,nxm) = 1;
      %      G(n,nxp) = 1;
            G(n,nym) = -1;
            G(n,n) = 1;
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

figure('Name','PartA')
surf(linspace(0,L,nx),linspace(0,W,ny),V);
%%surf(Vmap);
title(sprintf('Part a'));
xlabel('x');
ylabel('y');
