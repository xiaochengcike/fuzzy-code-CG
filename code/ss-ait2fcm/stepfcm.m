function [ center, obj_fcn] = stepfcm(udata,ldata, U_u,U_l, a, expo)
Udata=udata(:,1:3);
Ldata=ldata(:,1:3);
mf_u = U_u.^expo;      
mf_l = U_l.^expo;
center_u = (1-a)*(mf_u*Udata./(sum(mf_u,2)*ones(1,size(Udata,2)))); %new center
center_l = a*(mf_l*Ldata./(sum(mf_l,2)*ones(1,size(Ldata,2))));
% center_l(isnan(center_l))=0;
center=center_u+center_l;
dist_u1 = distfcm(center, Udata);   
dist_l1= distfcm(center, Ldata);
% dist_u2 = mdistfcm(center, Udata);   
% dist_l2= mdistfcm(center, Ldata);
dist_u=dist_u1;
dist_l=dist_l1;
obj_fcn = (1-a)*sum(sum((dist_u).*mf_u))+a*sum(sum((dist_l).*mf_l));  % objective function
% tmp = dist_u.^(-1/(expo-1));      
% U_new = tmp./(ones(cluster_n, 1)*sum(tmp));