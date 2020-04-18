% Get a list of all txt files in the current folder, or subfolders of it.

% fds = fileDatastore('*.mov', 'ReadFcn', @importdata)
fds = fileDatastore('C:\Users\Adm\Desktop\Temporal-Features\LIVE Video Quality Challenge (VQC) Database\Video\*.mp4', 'ReadFcn', @importdata)
fullFileNames = fds.Files

numFiles = length(fullFileNames)

% Loop over all files reading them in and plotting them.

for k = 1 : numFiles

    fprintf('Now reading file %s\n', fullFileNames{k});

    % Now have code to read in the data using whatever function you want.

    % Now code to plot the data or process it however you want...

end