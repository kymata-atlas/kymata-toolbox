unixCommand = ['setenv SUBJECTS_DIR /imaging/at03/LexproMEG/nme_subject_dir'];  % for some reasonnot working. Do from shell
fprintf(['[unix:] ' unixCommand '\n']);
unix(unixCommand);


% Average STCs
for w = 1:numel(wordlist)
    
    thisword = char(wordlist(w));
    disp([thisword]);
    temprh = [];
    templh = [];
    sensordatarh = [];
    sensordatalh = [];
    
    for p = 1:numel(participentIDlist) 

        %lh-side
        lhfilename = [rootCodeOutputPath 'Version4_source_level_CUDA/' experimentName, '/2-single-trial-source-data/averagemesh-vert2562-smooth5-elisinvsol+diagnoise/'  char(participentIDlist(p)) '-' thisword '-lh.stc'];
        if exist(lhfilename,'file')
            sensordatalh = mne_read_stc_file(lhfilename);
            
            templh(:,:,p) = sensordatalh.data(:, :);
        end
        
        %rh-side       
        rhfilename = [rootCodeOutputPath 'Version4_source_level_CUDA/' experimentName, '/2-single-trial-source-data/averagemesh-vert2562-smooth5-elisinvsol+diagnoise/' char(participentIDlist(p)) '-' thisword '-rh.stc'];
        if exist(rhfilename,'file')

            sensordatarh = mne_read_stc_file(rhfilename);
            
            temprh(:,:,p) = sensordatarh.data(:, :);
        end
    end
    
    %lh-side
    sensordatalh.data = mean(templh, 3);
    outputlh = [rootCodeOutputPath 'Version4_source_level_CUDA/' experimentName, '/3-averaged-by-trial-data/averagemesh-vert2562-smooth5-elisinvsol+diagnoise/' thisword '-lh.stc'];
    mne_write_stc_file(outputlh, sensordatalh);
    
    %rh-side
    sensordatarh.data = mean(temprh, 3);
    outputrh = [rootCodeOutputPath 'Version4_source_level_CUDA/' experimentName, '/3-averaged-by-trial-data/averagemesh-vert2562-smooth5-elisinvsol+diagnoise/' thisword '-rh.stc'];
    mne_write_stc_file(outputrh, sensordatarh);
    
end


