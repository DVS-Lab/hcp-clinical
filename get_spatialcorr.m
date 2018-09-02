
maindatadir = '/data/projects/ppi-effect-sizes';
basedir = pwd;

subs = load('Michelle_AllSubs_n146.txt');

% run-level metrics
fname = fullfile(basedir,'spatialcorr_subj.csv');
fid = fopen(fname,'w');
fprintf(fid,'subj,gam-wm,gam-emo,gam-soc,wm-soc,wm-emo,soc-emo\n');

data_mat = zeros(length(subs),6);
for s = 1:length(subs)
    subnum = subs(s);
    
    fsldir = fullfile(maindatadir,'fsl',num2str(subnum),'MNINonLinear','Results');
    
    mask = fullfile(fsldir,'L2_Gam_Act.gfeat','cope3.feat','mask.nii.gz'); % will replace with L3 mask once Michelle runs analyses
    gambling = fullfile(fsldir,'L2_Gam_Act.gfeat','cope3.feat','stats','zstat1.nii.gz');
    wm = fullfile(fsldir,'L2_WM_Act.gfeat','cope3.feat','stats','zstat1.nii.gz');
    social = fullfile(fsldir,'L2_Social_Act.gfeat','cope1.feat','stats','zstat1.nii.gz');
    emotion = fullfile(fsldir,'L2_Emotion_Act.gfeat','cope1.feat','stats','zstat1.nii.gz');
    
    cmd = sprintf('fslcc --noabs -p 4 -t -1 -m  %s %s %s  | awk ''{ print $3 }''',mask,gambling,wm);
    [~,result] = system(cmd);
    data_mat(s,1) = str2double(result);
    
    cmd = sprintf('fslcc --noabs -p 4 -t -1 -m  %s %s %s  | awk ''{ print $3 }''',mask,gambling,emotion);
    [~,result] = system(cmd);
    data_mat(s,2) = str2double(result);
    
    cmd = sprintf('fslcc --noabs -p 4 -t -1 -m  %s %s %s  | awk ''{ print $3 }''',mask,gambling,social);
    [~,result] = system(cmd);
    data_mat(s,3) = str2double(result);
    
    cmd = sprintf('fslcc --noabs -p 4 -t -1 -m  %s %s %s  | awk ''{ print $3 }''',mask,wm,social);
    [~,result] = system(cmd);
    data_mat(s,4) = str2double(result);
    
    cmd = sprintf('fslcc --noabs -p 4 -t -1 -m  %s %s %s  | awk ''{ print $3 }''',mask,wm,emotion);
    [~,result] = system(cmd);
    data_mat(s,5) = str2double(result);
    
    cmd = sprintf('fslcc --noabs -p 4 -t -1 -m  %s %s %s  | awk ''{ print $3 }''',mask,social,emotion);
    [~,result] = system(cmd);
    data_mat(s,6) = str2double(result);
    
    fprintf(fid,'%d,%f,%f,%f,%f,%f,%f\n',subnum,data_mat(s,:));
end
fclose(fid);

