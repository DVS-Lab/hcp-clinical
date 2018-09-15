
maindatadir = '/data/projects/ppi-effect-sizes';
basedir = pwd;

subs = load('Michelle_AllSubs_n146.txt');

% run-level metrics
fname = fullfile(basedir,'csnmap_corr_subj.csv');
fid = fopen(fname,'w');
fprintf(fid,'subj,csnmap1,csnmap2,csnmap3,csnmap4,csnmap5,csnmap6,csnmap7\n');

mask = fullfile(basedir,'groupmask.nii.gz');

data_mat = zeros(length(subs),7);
for s = 1:length(subs)
    subnum = subs(s);
    for m = 1:7
        fsldir = fullfile(maindatadir,'fsl',num2str(subnum),'MNINonLinear','Results');
        gambling = fullfile(fsldir,'L2_Gam_Act.gfeat','cope3.feat','stats','zstat1.nii.gz');
        csnmap = fullfile(basedir,['csnmap' num2str(m) '.nii.gz']);
        cmd = sprintf('fslcc --noabs -p 4 -t -1 -m  %s %s %s  | awk ''{ print $3 }''',mask,gambling,csnmap);
        [~,result] = system(cmd);
        data_mat(s,m) = str2double(result);
    end
    fprintf(fid,'%d,%f,%f,%f,%f,%f,%f,%f\n',subnum,data_mat(s,:));
end
fclose(fid);

