function add_to_classpath(classpath, directory, verbose)
    % Get all .jar files in the directory
    dirData = dir(directory);
    dirIndex = [dirData.isdir];
    jarlist = dir(fullfile(directory,'*.jar'));
    path_= cell(0);
    for i = 1:length(jarlist)
      if not_yet_in_classpath(classpath, jarlist(i).name)
        if verbose
          disp(strcat(['Adding: ',jarlist(i).name]));
        end
        path_{length(path_) + 1} = fullfile(directory,jarlist(i).name);
      end
    end

    %% Add them to the classpath
    if ~isempty(path_)
        javaaddpath(path_, '-end');
    end

    %# Recurse over subdirectories
    subDirs = {dirData(dirIndex).name};
    validIndex = ~ismember(subDirs,{'.','..'});

    for iDir = find(validIndex)
      nextDir = fullfile(directory,subDirs{iDir});
      add_to_classpath(classpath, nextDir, verbose);
    end
end

function test = not_yet_in_classpath(classpath, filename)
%% Test whether the library was already imported
expression = strcat([filesep filename '$']);
test = isempty(cell2mat(regexp(classpath, expression)));
end
