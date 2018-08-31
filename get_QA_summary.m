
maindatadir = '/data/projects/ppi-effect-sizes';
basedir = pwd;

subs = load('Michelle_AllSubs_n146.txt');
tasks = { 'SOCIAL', 'WM', 'GAMBLING', 'EMOTION' };
run_names = {'LR', 'RL'};

% run-level metrics
fname = fullfile(basedir,'headmotion_run.csv');
fid1 = fopen(fname,'w');
fprintf(fid1,'subj,task,run,abs_mean,rel_mean\n');

% subject-level metrics
fname = fullfile(basedir,'headmotion_subj.csv');
fid2 = fopen(fname,'w');
fprintf(fid2,'subj,abs_mean,rel_mean\n');

subj_motion = zeros(length(subs),2);
for s = 1:length(subs)
    subnum = subs(s);
    idx = 0;
    run_mat = zeros(8,2); % place to store the data
    for t = 1:length(tasks)
        task = tasks{t};
        for r = 1:length(run_names)
            idx = idx + 1;
            run_name = run_names{r};
            datadir = fullfile(maindatadir,'data',num2str(subnum),'MNINonLinear','Results',['tfMRI_' task '_' run_name]);
            abs_mean = load(fullfile(datadir,'Movement_AbsoluteRMS_mean.txt'));
            rel_mean = load(fullfile(datadir,'Movement_RelativeRMS_mean.txt'));
            fprintf(fid1,'%d,%s,%s,%f,%f\n',subnum,task,run_name,abs_mean,rel_mean);
            run_mat(idx,1) = abs_mean;
            run_mat(idx,2) = rel_mean;
        end
    end
    subj_motion(s,:) = mean(run_mat);
    fprintf(fid2,'%d,%f,%f\n',subnum,subj_motion(s,:));
end
fclose(fid1);
fclose(fid2);
figure,boxplot(subj_motion);
