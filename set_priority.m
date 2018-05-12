function term=set_priority(terms_string)

sequence_Terms={'sosy','dsyn','acty' ,'menp','bdsu','fndg','phsu','bhvr','blor','anst','antb', 'bacs', 'bdsy','biof','bpoc', 'bsoj', 'clna', 'clnd', 'diap',  'dora', 'edac', 'evnt', 'hlca', 'inbe', 'lbtr', 'medd', 'mobd', 'npop',  'orch', 'orgf', 'patf', 'phsf', 'socb', 'topp'};
for i=1:34
    if ~isempty(cell2mat(strfind(terms_string,sequence_Terms(i))))
        term=sequence_Terms(i);
        break;
    end
end