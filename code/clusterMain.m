% Executes cluster analysis from single script

codePath = pwd;

touch(fullfile(pwd, '/cluster'));
touch(fullfile(pwd, '/cluster/output'));
touch(fullfile(pwd, '/cluster/error'));
touch(fullfile(pwd, '/cluster/script'));

delete(fullfile(pwd, '/cluster/output/*'));
delete(fullfile(pwd, '/cluster/error/*'));
delete(fullfile(pwd, '/cluster/script/*'));

PBS = '#PBS -l nodes=1:ppn=1,walltime=3:00:00\n#PBS -m abe\n';
command = 'matlab -nodesktop -nodisplay -nojvm -nosplash -r ';
matlab_call = ['\"cd ' pwd '; clusterRun; exit;\"'];

qsub_call = ['!qsub -N clusterRun -o ' fullfile(pwd, '/cluster/output/stdout_clusterRun') ' -e ' fullfile(pwd, '/cluster/error/stderr_clusterRun') ' ' fullfile(pwd, '/cluster/script/script_clusterRun')]; 

txt = [PBS command matlab_call];
fid = fopen(fullfile(pwd, '/cluster/script/script_clusterRun'), 'w');
fprintf(fid, txt);
fclose(fid);

% Evaluate qsub with script
disp(qsub_call);
eval(qsub_call);
