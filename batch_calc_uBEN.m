% Toolbox for batch processing ASL perfusion based fMRI data.
% All rights reserved.
% Ze Wang @ TRC, CFN, Upenn 2004
par;
% get the subdirectories in the main directory
for sb = 1:length(PAR.subjects) % for each subject 
    sprintf('uBEN calc. subject %u .........',sb)
    %go get the sessions
    for ses=1:PAR.nsess(sb)
        %now get all images to smooth!
        %prepare directory
        %P=[];
        for c=1:PAR.ncond
            if isempty(PAR.condirs{sb,ses,c}) continue; end
            P=[];
           
%             Ptmp=spm_select('FPList', PAR.condirs{sb,ses,c}, ['^r' PAR.subjects{sb} '.*' PAR.confilters{c} '.*\.img$']);
            P=spm_select('FPList', PAR.condirs{sb,ses,c}, ['^sflt.*\.nii$']);
            if isempty(P)
              fprintf('!!!!!! No images found for %s session %d and condition %d\n',PAR.subjects{sb},ses,c);
              continue;
            end
            v=spm_vol(P);
            if size(v,1)<120, continue; end
            cd(PAR.condirs{sb,ses,c})

            pmask=spm_select('FPList',PAR.condirs{sb,ses,c},['^brainmask\.nii$']);
            oimg=fullfile(PAR.condirs{sb,ses,c}, ['uBEN' PAR.subjects{sb}  '.nii']);              

%             str=['!' PAR.benexe ' -d ' num2str(PAR.dim) ' -r ' num2str(PAR.r) ...
%                 '-ndummies 2 -tlen_2use 136 -otype 2  -s 1 -c 30 -i ' P ' -m ' pmask  ' -o ' oimg];
            str=['!' PAR.benexe ' -d ' num2str(PAR.dim) ' -r ' num2str(PAR.r) ...
                ' -num_dummies 4  -c 30 -i ' P ' -m ' pmask  ' -o ' oimg];
            if isunix
                eval(str);
            else
                system(str);
            end
       end
    end
end

