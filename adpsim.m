function [y,errest,iflg,nofun]=adpsim(a,b,tol,fun)
% an implementation of adaptive Simpson quadrature
% user must supply the integrand,fun. 
% a,b :limits of integration,tol:absolute error tolerance  
% errest: estimated error
% iflg: mode of return, gives number of subintervals where 
% maximum number (levmax=10) of bisections is required and value is
% accepted by default. The larger iflg, the less confidence one
% should have in the computed value, y.
% nofun: number of fun evaluations
%initialization
y=0;iflg=0;jflg=0;errest=0;levmax=10;
fsave=zeros(levmax,3);xsave=zeros(levmax,3);simpr=zeros(levmax);
%protect against unreasonable tol
tol2=tol+10*eps;
tol1=tol2*15/(b-a);

x=a:(b-a)/4:b;
for j=1:5
	f(j)=feval(fun,x(j));
end
nofun=5;
level=1;
%level=0 means entire interval is covered, hence finished
while level>0
% save right half subinterval info
for k=1:3
	fsave(level,k)=f(k+2);
	xsave(level,k)=x(k+2);
end
h=(x(5)-x(1))/4;
simpr(level)=(h/3)*(f(3)+4*f(4)+f(5));
if jflg<=0
	simp1=2*(h/3)*(f(1)+4*f(3)+f(5));
end
simpl=(h/3)*(f(1)+4*f(2)+f(3));
simp2=simpl+simpr(level);
diff=abs(simp1-simp2);
if diff<=tol1*4*h
%accept approx on current subinterval
	level=level-1;
	jflg=0;
%we use the conservative strategy of accepting the two-panel composite 
%Simpson rule. The method described on the web page uses y=y+simp1.
	y=y+simp2;
	errest=errest+diff/15;
	if level<=0
		fprintf('predicted error bound= %g. \n',errest)
		fprintf('number of times integrand was evaluated:  %g. \n', nofun)
		fprintf('the computed value of the integral is :  %g. \n',y)
		return
	end
	for j=1:3
		jj=2*j-1;
		f(jj)=fsave(level,j);
		x(jj)=xsave(level,j);
	end
	
else
	level=level+1;
	simp1=simpl;
	if level <= levmax
		jflg=1;
		f(5)=f(3);f(3)=f(2);
		x(5)=x(3);x(3)=x(2);
	else%levmax is reached, accept value computed and continue
		iflg=iflg+1;
		level=level-1;
		jflg=0;
		y=y+simp2;
		errest=errest+diff/15;
	end
end
	for k=1:2
		kk=2*k;
		x(kk)=.5*(x(kk+1)+x(kk-1));
		f(kk)=feval(fun,x(kk));
	end
nofun=nofun+2;
end
